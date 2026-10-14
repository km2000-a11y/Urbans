extends Node

var mode: String
var win_screen_radar: Node
var player_car: CarController
var race_started: bool = false
var is_lan := false
var career_progress: Dictionary = {}  # cup_id -> { "normal":false, "duel":false, "elimination":false, "radar":false }
var traffic_scene_paths: Array[String] = [
	"res://nissan_micra.tscn",
	"res://toyota_camry.tscn",
	"res://mercedes_sl.tscn",
	"res://astro.tscn",
	"res://bus.tscn"
]

@onready var finish_flash := $FinishFlash
@onready var start_countdown := $Start
@onready var leaderboard := $Leaderboard if has_node("Leaderboard") else null
@onready var normal_hud := $HUD
@onready var elimination_hud := $EliminationHud
@onready var cop_chase_hud := $CopChaseHud
@onready var cop_chase_ui := $CopChaseHud/Control
@onready var radar_target_label := $HUD/Control/RadarTargetLabel

func safe_get(node: Node, path: String) -> Node:
	if node and node.has_node(path):
		return node.get_node(path)
	return null

func _ready():
	if Modes.mode == "Radar Race":
		MusicManager.play_race_music()
	start_countdown.countdown_finished.connect(_on_countdown_finished)
	mode = Modes.mode if Modes.mode != null else ""
	if mode == "":
		mode = "Normal Race"

	Cars.load_color()
	career_progress = ClubCups.career_progress
	is_lan = GameMode.game_mode == "Multi-Device"
	$EliminationWinScreen.visible = false
	if GameMode.game_mode == "Road Challenge":
		Modes.mode = "Normal Race"

	var track_name := TrackName.track_name

	if not TrackRegistry.tracks.has(track_name):
		push_error("Track not registered: " + track_name)
		return

	var track_file: String = TrackRegistry.tracks[track_name]
	var track_scene := load(track_file)

	if track_scene:
		var track_instance = track_scene.instantiate()
		track_instance.name = track_name
		add_child(track_instance)

		await get_tree().process_frame
		await get_tree().process_frame

		# Трафик только в одиночной игре (в LAN он не синхронизируется)
		if Modes.mode!="Radar Race":
			for i: int in range(14):
				spawn_traffic()
	else:
		push_error("Track file missing: " + track_file)
		return

	if is_lan:
		_spawn_lan_player()
	elif mode == "Duel":
		_setup_duel()
	elif mode.to_lower() == "normal race":
		_setup_normal_race()
	elif mode == "Elimination":
		_setup_elimination()
	elif mode == "Cop Chase":
		_setup_cop_chase()
	else:
		_spawn_player_free_drive()

	if mode == "Radar Race":
		var target := Cars.get_radar_target_speed()
		var formatted := _format_radar_speed(target)
		radar_target_label.text = "Target: %s" % formatted

		var ws_scene = load("res://Scenes/win_screen_radar.tscn")
		win_screen_radar = ws_scene.instantiate()
		add_child(win_screen_radar)
		win_screen_radar.visible = false
		radar_target_label.visible = true
	else:
		radar_target_label.visible = false

	finish_flash.visible = false
	if leaderboard:
		leaderboard.visible = false

func _start_mode_countdown(cars: Array):
	start_countdown.start_countdown(cars)
func _format_radar_speed(speed_kmh: float) -> String:
	var use_mph := SpeedSettings.SPEED_UNIT == "mph"

	if use_mph:
		var mph := speed_kmh * 0.621371
		return "%d mph" % mph
	else:
		return "%d km/h" % speed_kmh
func _process(delta):
	if not race_started:
		return

	match mode:
		"Duel":
			DuelManager.update_duel()

		"Radar Race":
			pass

		_:
			if mode.to_lower() == "normal race":
				if is_lan:
					# LAN safety: only update if car is valid
					if player_car and is_instance_valid(player_car):
						NormalRaceManager.update_race()
				else:
					NormalRaceManager.update_race()

			elif mode == "Elimination":
				EliminationManager.update_race()

			elif mode == "Cop Chase":
				CopChaseManager.update_chase(delta)

func _input(event):
	if event.is_action_pressed("pause_menu"):
		if has_node("PauseMenu"):
			$PauseMenu.toggle_pause()


func _spawn_player_free_drive():
	var path := Cars.selected_car
	if path == "":
		push_error("No player car selected!")
		return

	var scene := load(path)
	if scene == null:
		push_error("Player car scene missing: " + path)
		return

	player_car = scene.instantiate()
	add_child(player_car)

	if has_node("Speedometer"):
		get_node("Speedometer").target_car = player_car

	_apply_color_to_car(player_car, Cars.selected_color)

	var root := get_node(TrackName.track_name)

	var spawn := safe_get(root, "SpawnPoint")
	if spawn:
		player_car.global_transform = spawn.global_transform
	else:
		print("WARNING: Track has no SpawnPoint, using origin")
		player_car.global_transform.origin = Vector3.ZERO

	var radar_trap := safe_get(root, "RadarTrap")
	if radar_trap:
		if not radar_trap.is_connected("body_entered", Callable(self, "_on_radar_trap_body_entered")):
			radar_trap.body_entered.connect(_on_radar_trap_body_entered)
		print("RadarTrap connected from:", TrackName.track_name)
	else:
		print("No RadarTrap found in:", TrackName.track_name)

	_force_player_camera()

func _setup_duel():
	var root := get_node(TrackName.track_name)

	var psp := safe_get(root, "SpawnPoint")
	var asp := safe_get(root, "AISpawnPoint")

	DuelManager.player_spawn = psp.global_position if psp else Vector3.ZERO
	DuelManager.ai_spawn = asp.global_position if asp else DuelManager.player_spawn

	DuelManager.player_car_path = Cars.selected_car

	if GameMode.game_mode == "Club Cups":
		Cars.apply_championship_class(ChampionshipState.active_cup)

		var cup_id := ChampionshipState.active_cup
		var filtered := ClubCups.get_available_cars(cup_id)

		if filtered.size() > 0:
			var chosen := filtered[randi() % filtered.size()]
			DuelManager.ai_car_path = Cars.car_scene_paths[chosen]
			Cars.selected_ai_car_name = chosen
		else:
			DuelManager.ai_car_path = Cars.selected_car
	else:
		DuelManager.ai_car_path = Cars.selected_ai_car if Cars.selected_ai_car != "" else Cars.selected_car

	DuelManager.spawn_duel(self)
	DuelManager.main_scene = self

	player_car = DuelManager.player_car
	_force_player_camera()

	var cars = DuelManager.get_all_race_cars()
	start_countdown.start_countdown(cars)

func _setup_normal_race():
	if not is_lan:
		if player_car:
			player_car.queue_free()
		player_car = null

	var root := get_node(TrackName.track_name)

	var spawn := safe_get(root, "SpawnPoint")
	NormalRaceManager.player_spawn = spawn.global_position if spawn else Vector3.ZERO
	NormalRaceManager.player_car_path = Cars.selected_car

	NormalRaceManager.ai_spawns = []
	for i in range(1, 8):
		var ai_sp := safe_get(root, "AISpawnPoint" + str(i))
		NormalRaceManager.ai_spawns.append(ai_sp.global_position if ai_sp else NormalRaceManager.player_spawn)

	Cars.apply_championship_class(ChampionshipState.active_cup)
	print("Selected class for championship:", Cars.selected_class)

	if GameMode.game_mode == "Club Cups":
		var filtered_names = ClubCups.get_available_cars(ChampionshipState.active_cup)
		var filtered_paths = []

		for name in filtered_names:
			if Cars.car_scene_paths.has(name):
				filtered_paths.append(Cars.car_scene_paths[name])
			else:
				print("WARNING: No scene path for:", name)

		NormalRaceManager.ai_car_paths = filtered_paths
	else:
		NormalRaceManager.ai_car_paths = Cars.get_ai_paths_for_class(Cars.selected_class)

	NormalRaceManager.spawn_race(self)

	player_car = NormalRaceManager.player_car
	_force_player_camera()

	var cars = NormalRaceManager.get_all_race_cars()
	start_countdown.start_countdown(cars)
	start_countdown.connect("countdown_finished", Callable(NormalRaceManager, "on_countdown_finished"))

func _setup_elimination():
	if player_car:
		player_car.queue_free()
	player_car = null

	normal_hud.visible = false

	var root := get_node(TrackName.track_name)

	var spawn := safe_get(root, "SpawnPoint")
	EliminationManager.player_spawn = spawn.global_position if spawn else Vector3.ZERO

	EliminationManager.ai_spawns = []
	for i in range(1, 8):
		var ai_sp := safe_get(root, "AISpawnPoint" + str(i))
		EliminationManager.ai_spawns.append(ai_sp.global_position if ai_sp else EliminationManager.player_spawn)

	EliminationManager.player_car_path = Cars.selected_car

	if GameMode.game_mode == "Club Cups":
		Cars.apply_championship_class(ChampionshipState.active_cup)

		var cup_id := ChampionshipState.active_cup
		EliminationManager.ai_car_paths = ClubCups.get_available_cars(cup_id)
	else:
		EliminationManager.ai_car_paths = Cars.get_ai_paths_for_class(Cars.selected_class)

	var hud_scene := load("res://Scenes/elimination_hud.tscn")
	var hud: CanvasLayer = hud_scene.instantiate()
	hud.visible = false
	add_child(hud)

	EliminationManager.hud = hud
	EliminationManager.main_scene = self

	EliminationManager.connect("player_eliminated", _on_player_eliminated)
	EliminationManager.connect("elimination_win", _on_elimination_win)

	EliminationManager.spawn_race(self)

	player_car = EliminationManager.player_car
	_force_player_camera()

	var cars = EliminationManager.get_all_race_cars()
	start_countdown.start_countdown(cars)
	start_countdown.connect("countdown_finished", Callable(EliminationManager, "on_countdown_finished"))

func _on_elimination_countdown_finished():
	if EliminationManager.hud:
		EliminationManager.hud.visible = true

func _on_player_eliminated():
	show_finish(false)

func _on_elimination_win(car):
	show_finish(true)

func _setup_cop_chase():
	if player_car:
		player_car.queue_free()
	player_car = null

	normal_hud.visible = false
	elimination_hud.visible = false
	cop_chase_hud.visible = false

	var root := get_node(TrackName.track_name)

	CopChaseManager.player_car_path = Cars.selected_car
	CopChaseManager.ai_car_paths = Cars.get_ai_paths_for_class(Cars.selected_class)

	CopChaseManager.main_scene = self
	CopChaseManager.hud = cop_chase_hud

	CopChaseManager.connect("chase_failed", _on_chase_failed)
	CopChaseManager.connect("chase_completed", _on_chase_completed)
	CopChaseManager.connect("time_left_updated", _on_chase_timer_updated)

	CopChaseManager.spawn_chase(self)

	player_car = CopChaseManager.player_car
	_force_player_camera()

	var cars = CopChaseManager.get_all_race_cars()
	start_countdown.start_countdown(cars)
	start_countdown.connect("countdown_finished", Callable(CopChaseManager, "on_countdown_finished"))

func _on_chase_failed():
	show_finish(false)

func _on_chase_completed():
	show_finish(true)

func _on_chase_timer_updated(time_left):
	if time_left < 10.0:
		cop_chase_ui.modulate = Color(1, 0.3, 0.3)
	else:
		cop_chase_ui.modulate = Color(1, 1, 1)

func _on_cop_chase_countdown_finished():
	if cop_chase_hud:
		cop_chase_hud.visible = true

func _force_player_camera():
	if not player_car:
		return

	for node in get_tree().get_nodes_in_group("cars"):
		if node is CarController and node != player_car:
			if node.has_node("Camera3D"):
				node.get_node("Camera3D").current = false

	if player_car.has_node("Camera3D"):
		player_car.get_node("Camera3D").current = true

func _apply_color_to_car(car: Node, color: Color):
	if car.has_node("ModelRoot/Body"):
		var body = car.get_node("ModelRoot/Body")
		for child in body.get_children():
			if child is MeshInstance3D:
				var mat = child.get_active_material(0)
				if mat:
					var unique_mat = mat.duplicate()
					unique_mat.albedo_color = color
					child.set_surface_override_material(0, unique_mat)

func _on_radar_trap_body_entered(body):
	if mode != "Radar Race":
		return

	var car = body
	while car and not (car is CarController):
		car = car.get_parent()

	if car is CarController:
		var speed := int(round(car.velocity.length() * 3.6))
		var target_speed: int = Cars.get_radar_target_speed()
		var success := speed >= target_speed

		player_car.controls_enabled = false
		win_screen_radar.show_win(success)

		if success and GameMode.game_mode == "Club Cups":
			_update_career_progress()
			ClubCups.save_progress()

		MusicManager.stop_music()

	finish_flash.flash()
	_screech_to_halt()

func _fix_wrong_way(car: CarController, root: Node):
	if car == null:
		print("Cannot fix direction: car is null")
		return

	var wp1 := safe_get(root, "Waypoints/WP1")
	if wp1 == null:
		print("No WP1 in this track, skipping direction fix")
		return

	var dir: Vector3 = (wp1.global_position - car.global_position).normalized()
	if dir.length() < 0.1:
		dir = Vector3.FORWARD

	var up := Vector3.UP
	var right := up.cross(dir).normalized()
	var forward := dir

	var basis := Basis(right, up, forward)
	car.global_transform.basis = basis
	print("AI direction forced using basis")

func disable_all_ai():
	for node in get_tree().get_nodes_in_group("cars"):
		if node is CarController:
			node.is_ai = false

func _screech_to_halt():
	for node in get_tree().get_nodes_in_group("cars"):
		if node is CarController:
			node.controls_enabled = false
			node.hard_frozen = true
			node.velocity = Vector3.ZERO

func show_finish(player_won: bool):
	print("SHOW FINISH CALLED")
	print("PLAYER WON =", player_won)
	print("GAME MODE =", GameMode.game_mode)
	finish_flash.visible = true
	finish_flash.flash()

	_screech_to_halt()
	MusicManager.stop_music()

	# Do NOT override Duel, Elimination, Cop Chase, Club Cups, Radar Race
	if GameMode.game_mode == "Road Challenge":
		if GameMode.game_mode == "Free Race":
			pass  # free race stays free race
		elif Modes.mode == "Normal Race":
			Modes.mode = "Normal Race"  # Road Challenge race
		else:
			# Any other mode should NOT be treated as Road Challenge
			GameMode.game_mode = Modes.mode
	if player_won and GameMode.game_mode == "Club Cups":
		_update_career_progress()
		ClubCups.save_progress()

	# Club Cups reward logic stays here
	if player_won and GameMode.game_mode == "Club Cups":
		_update_career_progress()
		ClubCups.save_progress()
		var cup_id := ChampionshipState.active_cup
		var cup_data = ClubCups.career_progress.get(cup_id, {})
		var completed = cup_data["normal"] and cup_data["duel"] and cup_data["elimination"] and cup_data["radar"]
		if completed:
			_show_championship_reward(cup_id)
			ClubCups.complete_cup(cup_id)
			ClubCups.save_progress()

	# Leaderboard ALWAYS shows in Free Race and Normal Race
	if leaderboard:
		leaderboard.visible = true
		leaderboard.show_results(player_won)

		if player_won:
			print("YOU WIN!")
		else:
			print("YOU LOSE!")
func _show_championship_reward(cup_id: String):
	var reward_car := ""
	var reward_cash := 0

	if ClubCups.cup_rewards.has(cup_id):
		reward_car = ClubCups.cup_rewards[cup_id]

	if ClubCups.cash_rewards.has(cup_id):
		reward_cash = ClubCups.cash_rewards[cup_id]

	if leaderboard:
		leaderboard.visible = true
		leaderboard.show_reward(
			"Championship Completed!\n" +
			"Reward Car: " + reward_car + "\n" +
			"Cash Reward: $" + str(reward_cash)
		)
func _face_away_from_lap_line(car: CarController, root: Node):
	var lap_line := safe_get(root, "LapLine")
	if lap_line == null:
		print("No LapLine found in track:", TrackName.track_name)
		return

	var forward: Vector3 = lap_line.global_transform.basis.z.normalized()
	var away := -forward

	var target_pos := car.global_position + away
	car.look_at(target_pos, Vector3.UP)

# =========================================================
# LAN / MULTIPLAYER
# =========================================================

func _spawn_lan_player():
	var path := Cars.selected_car
	var my_id := multiplayer.get_unique_id()
	var scene := load(path)
	if scene == null:
		push_error("Player car scene missing: " + path)
		return

	player_car = scene.instantiate()
	player_car.name = str(my_id)

	setup_multiplayer_sync(player_car)
	player_car.set_multiplayer_authority(my_id)
	add_child(player_car, true)
	_apply_color_to_car(player_car, Cars.selected_color)

	var root := get_node(TrackName.track_name)
	var spawn = safe_get(root, "SpawnPoint")
	if spawn:
		var t: Transform3D = spawn.global_transform
		if my_id == 1:
			t.origin -= spawn.global_transform.basis.x * 3.0
		player_car.global_transform = t

	_force_player_camera()

	var c := Cars.selected_color
	rpc("spawn_remote_player", my_id, path, c.r, c.g, c.b)

	print("Spawned local LAN player:", my_id)

@rpc("any_peer")
func spawn_remote_player(id: int, car_path: String, cr: float, cg: float, cb: float):
	if has_node(str(id)):
		return

	var scene := load(car_path)
	if scene == null:
		push_error("Remote car scene missing: " + car_path)
		return

	var car = scene.instantiate()
	car.name = str(id)

	setup_multiplayer_sync(car)
	car.set_multiplayer_authority(id)
	add_child(car, true)
	_apply_color_to_car(car, Color(cr, cg, cb))

	# Камера удалённой машины не должна перехватывать вид
	if car.has_node("Camera3D"):
		car.get_node("Camera3D").current = false

	var root := get_node(TrackName.track_name)
	var spawn = safe_get(root, "SpawnPoint")
	if spawn:
		var t: Transform3D = spawn.global_transform
		if id == 1:
			t.origin -= spawn.global_transform.basis.x * 3.0
		car.global_transform = t

	print("Spawned remote player", id)

func setup_multiplayer_sync(car_node: Node3D):
	if car_node.has_node("MultiplayerSynchronizer"):
		return
	var sync = MultiplayerSynchronizer.new()
	sync.name = "MultiplayerSynchronizer"
	var config = SceneReplicationConfig.new()
	config.add_property(":sync_transform")
	config.add_property(":sync_velocity")
	sync.replication_config = config
	car_node.add_child(sync)

# =========================================================
# CAREER / REWARDS
# =========================================================

func _update_career_progress():
	print("UPDATE CAREER PROGRESS CALLED")
	var cup_id = ChampionshipState.active_cup

	if not career_progress.has(cup_id):
		career_progress[cup_id] = {
			"normal": false,
			"duel": false,
			"elimination": false,
			"radar": false
		}

	match mode:
		"Normal Race":
			career_progress[cup_id]["normal"] = true
		"Duel":
			career_progress[cup_id]["duel"] = true
			
func _on_countdown_finished():
	MusicManager.play_race_music()
	
func spawn_traffic() -> void:
	var root: Node = get_node(TrackName.track_name)
	var wp_root: Node = safe_get(root, "Waypoints")

	if wp_root == null:
		return

	var waypoints: Array = wp_root.get_children()
	if waypoints.is_empty():
		return

	var random_wp: Node3D = waypoints.pick_random()
	var chosen_path: String = get_random_traffic_path()
	var car_scene: PackedScene = load(chosen_path)

	if car_scene == null:
		push_error("Traffic scene missing: " + chosen_path)
		return

	var traffic_car: CharacterBody3D = car_scene.instantiate()

	if not traffic_car.is_in_group("traffic"):
		traffic_car.add_to_group("traffic")

	add_child(traffic_car)

	var spawn_pos: Vector3 = random_wp.global_position
	var space = random_wp.get_world_3d().direct_space_state

	var ray_start = spawn_pos + Vector3.UP * 2.0
	var ray_end = spawn_pos + Vector3.DOWN * 3.0

	var query := PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	query.exclude = [traffic_car]

	var result := space.intersect_ray(query)

	if not result.is_empty():
		var normal: Vector3 = result["normal"]
		if normal.dot(Vector3.UP) > 0.5:
			spawn_pos = result["position"] + Vector3.UP * 1.05
		else:
			spawn_pos.y += 1.05
	else:
		spawn_pos.y += 1.05

	traffic_car.global_position = spawn_pos
	traffic_car.global_transform.basis = random_wp.global_transform.basis


func get_random_traffic_path() -> String:
	var roll := randi_range(1, 100)

	if roll <= 35:
		return "res://nissan_micra.tscn"      # 35%
	elif roll <= 65:
		return "res://toyota_camry.tscn"      # 30%
	elif roll <= 85:
		return "res://astro.tscn"             # 20%
	elif roll <= 97:
		return "res://mercedes_sl.tscn"       # 12%
	else:
		return "res://bus.tscn"               # 3%
