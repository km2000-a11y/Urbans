extends Node

var player_car_path: String = ""
var ai_car_paths: Array = []        # 7 AI car scene paths

var player_spawn: Vector3 = Vector3.ZERO
var ai_spawns: Array = []

var player_car: CarController = null
var ai_cars: Array[CarController] = []

var race_active: bool = false
var total_laps: int = 3

var hud: Node = null
var main_scene: Node = null

# lap + waypoint tracking
var car_laps := {}
var last_wp := {}
var lap_cooldown := {}





func spawn_race(scene: Node) -> void:
	race_active = false
	CarController.used_ai_names = CarController.ai_names.duplicate()

	# Remove old cars
	if player_car and player_car.is_inside_tree():
		player_car.queue_free()

	for ai in ai_cars:
		if ai and ai.is_inside_tree():
			ai.queue_free()

	ai_cars.clear()
	
	# Career lap rules
	if Cars.selected_class == "suv"or "colossus":
		total_laps = 2
	else:
		total_laps = 3

	await get_tree().process_frame

	var root := scene.get_node(TrackName.track_name)

	player_spawn = root.get_node("SpawnPoint").global_transform.origin

	ai_spawns.clear()
	for i in range(7):
		ai_spawns.append(root.get_node("AISpawnPoint" + str(i + 1)).global_transform.origin)

	RaceResults.clear()
	main_scene = scene
	hud = scene.get_node("HUD")


	# PLAYER
	var player_scene := load(player_car_path)
	player_car = player_scene.instantiate() as CarController
	player_car.is_ai = false
	player_car.global_transform = root.get_node("SpawnPoint").global_transform
	player_car.controls_enabled = false
	player_car.driver_name = "Player"
	player_car.car_name = Cars.selected_car_name
	scene.add_child(player_car)

	_apply_player_color(player_car)

	await get_tree().process_frame
	await get_tree().process_frame

	if player_car and is_instance_valid(player_car):
		if player_car.has_node("Camera3D"):
			player_car.get_node("Camera3D").current = true


	# AI CARS
	# AI CARS
	# AI CARS — USE THE CUP LIST PROVIDED BY RaceManager
	# ============================
# AI CARS — UNIVERSAL SAFE BLOCK
# ============================

	# ============================
# AI CARS — SINGLE PLAYER ONLY
# ============================

		# AI CARS — UNIVERSAL SAFE BLOCK
	ai_cars.clear()

	# Single-player: up to 7 AI (8 cars total)
	# Multi-Device (LAN): 4 players total, NO AI here
	var final_ai_paths: Array = []

	# LAN mode → let LANManager handle remote players, we only keep the local player here
	if GameMode.game_mode == "Multi-Device":
		# No AI spawning in LAN; player_car already spawned above.
		return

	# Non-LAN: normal AI logic
	if GameMode.game_mode == "Club Cups":
		# Club Cups → ai_car_paths already configured by the cup system
		final_ai_paths = ai_car_paths.duplicate()
	else:
		# Normal modes → auto-detect class and get AI list from Cars
		Cars.apply_auto_class_if_not_club()
		final_ai_paths = Cars.get_ai_paths_for_class(Cars.selected_class)

	# Safety: if nothing came back, at least use the player car as AI
	if final_ai_paths.is_empty():
		final_ai_paths = [player_car_path]

	# Spawn up to 7 AI for single-player (SpawnPoint1..7)
	for i in range(ai_spawns.size()):
		var index := i % final_ai_paths.size()
		var ai_path: String = final_ai_paths[index]

		var ai_scene := load(ai_path)
		if ai_scene == null:
			continue

		var ai := ai_scene.instantiate() as CarController
		scene.add_child(ai)

		# Camera off
		if ai.has_node("Camera3D"):
			ai.get_node("Camera3D").current = false

		# Spawn position
		var spawn_node := root.get_node("AISpawnPoint" + str(i + 1))
		ai.global_transform = spawn_node.global_transform

		# AI flags
		ai.is_ai = true
		ai.controls_enabled = false

		# Random AI name
		ai.driver_name = ai.ai_names[randi() % ai.ai_names.size()]

		# Resolve car name from path
		var found_name := ""
		for name in Cars.car_scene_paths.keys():
			if Cars.car_scene_paths[name] == ai_path:
				found_name = name
				break

		if found_name == "":
			found_name = Cars.selected_car_name

		ai.car_name = found_name

		_apply_random_ai_color(ai)
		ai_cars.append(ai)





	await get_tree().process_frame
	await get_tree().process_frame

	# WAYPOINTS
	var wp_root := scene.find_child("Waypoints", true, false)
	player_car.set_waypoints(wp_root)

	for ai in ai_cars:
		ai.set_waypoints(wp_root)

	# INIT lap dictionaries
	init_lap_system()


	hud.update_lap(1, total_laps)
	hud.update_position(ai_cars.size() + 1, ai_cars.size() + 1)

	MusicManager.stop_music()
	MusicManager.play_race_music()			
	var all_cars = get_all_race_cars()
	scene.get_node("Start").start_countdown(all_cars)

func on_countdown_finished():
	race_active = true

	player_car.controls_enabled = true
	for ai in ai_cars:
		ai.controls_enabled = true



func init_lap_system():
	car_laps.clear()
	last_wp.clear()

	car_laps[player_car] = 0
	last_wp[player_car] = 0

	for ai in ai_cars:
		car_laps[ai] = 0
		last_wp[ai] = 0



func register_lap(body: Node) -> void:
	if not race_active:
		return

	var car := body
	while car != null and not (car is CarController):
		car = car.get_parent()

	if car == null:
		return

	if not car_laps.has(car):
		return

	if lap_cooldown.get(car, false):
		return

	# PLAYER LAP COUNTS HERE
	car_laps[car] += 1

	lap_cooldown[car] = true
	_start_lap_cooldown(car)

	if car == player_car:
		_check_finish()



func get_all_race_cars() -> Array:
	var arr = []
	if player_car:
		arr.append(player_car)
	for ai in ai_cars:
		arr.append(ai)
	return arr



func _start_lap_cooldown(car):
	await get_tree().create_timer(0.8).timeout
	lap_cooldown[car] = false


func _check_finish() -> void:
	if not race_active:
		return

	var player_finished: bool = car_laps[player_car] >= total_laps

	if not player_finished:
		return

	var player_position := _calculate_position()
	var player_won := (player_position <= 3)

	if player_won:
		_end_race("Player")
	else:
		_end_race("AI")
func _get_wp_index(car: CarController) -> int:
	var waypoints := player_car.waypoints
	if waypoints.is_empty():
		return 0

	var best_index := 0
	var best_dist := INF

	for i in range(waypoints.size()):
		var wp := waypoints[i] as Node3D
		var d := car.global_position.distance_to(wp.global_position)
		if d < best_dist:
			best_dist = d
			best_index = i

	return best_index

func _distance_to_next_wp_from_index(car: CarController, wp_index: int) -> float:
	var waypoints := player_car.waypoints
	if waypoints.is_empty():
		return 0.0

	var next_wp := wp_index + 1
	if next_wp >= waypoints.size():
		next_wp = 0

	var wp := waypoints[next_wp] as Node3D
	return car.global_position.distance_to(wp.global_position)

func _end_race(winner: String) -> void:
	race_active = false
	player_car.controls_enabled = false
	for ai in ai_cars:
		ai.controls_enabled = false

	var participants = []
	var total_wp := player_car.waypoints.size()

	var p_progress = (car_laps[player_car] * total_wp) + player_car.current_wp
	participants.append({
		"car_obj": player_car,
		"name": player_car.driver_name,
		"car_name": player_car.car_name,
		"progress": p_progress,
		"dist": _distance_to_next_wp(player_car),
		"real_time": player_car.total_race_time,
		"finished": car_laps[player_car] >= total_laps
	})

	for ai in ai_cars:
		var ai_progress = (car_laps[ai] * total_wp) + ai.current_wp
		participants.append({
			"car_obj": ai,
			"name": ai.driver_name,
			"car_name": ai.car_name,
			"progress": ai_progress,
			"dist": _distance_to_next_wp(ai),
			"real_time": ai.total_race_time,
			"finished": car_laps[ai] >= total_laps
		})

	participants.sort_custom(func(a, b):
		if a["progress"] != b["progress"]:
			return a["progress"] > b["progress"]
		return a["dist"] < b["dist"]
	)

	RaceResults.clear()

	var winner_time = participants[0]["real_time"]

	for p in participants:
		var final_time: int

		if p["finished"]:
			final_time = p["real_time"]
		else:
			# Accurate AI finish time
			var ai := p["car_obj"] as CarController
			final_time = _estimate_ai_finish_time_for(ai)
			
		RaceResults.add_result(p["name"], p["car_name"], final_time)


	main_scene.show_finish(winner == "Player")
	hud.visible = false
	MusicManager.stop_music()


func update_race() -> void:
	# Race not active → nothing to update
	if not race_active:
		return

	# Player car must exist AND be valid
	if player_car == null or not is_instance_valid(player_car):
		return

	# Waypoints must exist (prevents early-frame crashes)
	if player_car.waypoints.is_empty():
		return

	# Get sorted cars safely
	var sorted := _sorted_cars()
	if sorted.is_empty():
		return

	# Calculate player position safely
	var player_pos := _calculate_position()

	# HUD updates (player_car guaranteed valid here)
	hud.update_stopwatch(player_car.total_race_time)

	# Lap dictionary must use instance_id (LAN-safe)
	var lap :int = car_laps.get(player_car, 0)


	hud.update_lap(lap + 1, total_laps)
	hud.update_position(player_pos, ai_cars.size() + 1)

	# Finish check
	_check_finish()



func _distance_to_next_wp(car: CarController) -> float:
	if car.waypoints.is_empty():
		return 0.0

	var next_wp := car.current_wp + 1
	if next_wp >= car.waypoints.size():
		next_wp = 0

	var wp := car.waypoints[next_wp] as Node3D
	return car.global_position.distance_to(wp.global_position)


func _calculate_position() -> int:
	var sorted := _sorted_cars()

	for i in range(sorted.size()):
		if sorted[i] == player_car:
			return i + 1

	return 1

func _sorted_cars() -> Array:
	if not is_instance_valid(player_car) or player_car.waypoints.is_empty():
		  			
					return []
	var total_wp := player_car.waypoints.size()
	var cars := []

	for car in [player_car] + ai_cars:
		var lap :int= car_laps.get(car, 0)

		# compute waypoint index by proximity
		var wp_index := _get_wp_index(car)

		# pure progress: laps + waypoint index
		var progress :int= lap * total_wp + wp_index
		var dist := _distance_to_next_wp_from_index(car, wp_index)

		cars.append({
			"car": car,
			"progress": progress,
			"dist": dist
		})

	# sort: higher progress first, then closer to next WP
	cars.sort_custom(func(a, b):
		if a["progress"] != b["progress"]:
			return a["progress"] > b["progress"]
		return a["dist"] < b["dist"]
	)

	var result: Array = []
	for c in cars:
		result.append(c["car"])
	return result


func _apply_player_color(car: CarController) -> void:
	var color: Color = Cars.selected_color
	if car.has_node("ModelRoot/Body"):
		var body := car.get_node("ModelRoot/Body")
		for child in body.get_children():
			if child is MeshInstance3D:
				var mat: Material = child.get_active_material(0)
				if mat is BaseMaterial3D:
					mat.albedo_color = color


func _apply_random_ai_color(car: CarController) -> void:
	var name: String = car.car_name

	if not Cars.car_colors.has(name):
		return

	var palette: Array = Cars.car_colors[name]
	if palette.is_empty():
		return

	var random_color: Color = palette[randi() % palette.size()]

	if car.has_node("ModelRoot/Body"):
		var body := car.get_node("ModelRoot/Body")

		for child in body.get_children():
			if child is MeshInstance3D:
				var mesh_instance := child
				var mesh: Mesh = mesh_instance.mesh
				if mesh == null:
					return

				var surface_count := mesh.get_surface_count()

				var new_mat := StandardMaterial3D.new()
				new_mat.albedo_color = random_color

				for s in range(surface_count):
					mesh_instance.set_surface_override_material(s, new_mat)

func _estimate_ai_finish_time_for(ai: CarController) -> int:
	var lapline: Node3D = main_scene.find_child("LapLine", true, false)
	if lapline == null:
		return ai.total_race_time

	# 1) Compute full lap distance from waypoints
	var wp: Array = ai.waypoints
	if wp.is_empty():
		return ai.total_race_time

	var lap_dist: float = 0.0
	for i in range(wp.size()):
		var a: Vector3 = wp[i].global_position
		var b: Vector3 = wp[(i + 1) % wp.size()].global_position
		lap_dist += a.distance_to(b)

	# 2) Remaining laps
	var laps_done: int = car_laps.get(ai, 0)
	var laps_left: int = max(total_laps - laps_done, 0)

	# 3) Distance from current position to LapLine on this lap
	var remaining_dist: float = ai.distance_to_finish_line(lapline)

	# Add full laps still to go
	remaining_dist += lap_dist * float(laps_left)

	# 4) Use average race speed instead of raw current speed
	# Assume ai.total_race_time is in ms and current_speed is km/h or m/s depending on your setup.
	var race_time_sec: float = max(float(ai.total_race_time) / 1000.0, 0.1)
	var avg_speed: float = ai.distance_travelled / race_time_sec  # you should track this on the car

	# Fallback if avg_speed is not tracked or too small
	if avg_speed <= 1.0:
		avg_speed = clamp(ai.current_speed * 0.8, 10.0, 120.0)

	# 5) Time = distance / speed
	var remaining_time_ms: int = int((remaining_dist / avg_speed) * 1000)

	# Slight smoothing
	remaining_time_ms = int(remaining_time_ms * 1.03)

	return ai.total_race_time + remaining_time_ms


func force_player_camera():
	if player_car and player_car.has_node("Camera3D"):
		player_car.get_node("Camera3D").current = true
