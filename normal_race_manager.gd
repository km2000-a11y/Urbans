extends Node

var player_car_path: String = ""
var ai_car_paths: Array = []

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
var lap_cooldown := {}

func spawn_race(scene: Node) -> void:
	race_active = false
	# Сброс имен ботов
	if "ai_names" in CarController:
		CarController.used_ai_names = CarController.ai_names.duplicate()

	# Очистка старых машин
	if is_instance_valid(player_car): player_car.queue_free()
	for ai in ai_cars:
		if is_instance_valid(ai): ai.queue_free()
	ai_cars.clear()
		
	# Настройка кругов
	total_laps = 2 if Cars.selected_class == "suv" else 3

	await get_tree().process_frame

	var track_node = scene.get_node(TrackName.track_name)
	main_scene = scene
	hud = scene.get_node("HUD")

	# 1. СПАВН ИГРОКА
	var player_scene = load(player_car_path)
	player_car = player_scene.instantiate() as CarController
	player_car.is_ai = false
	player_car.driver_name = "Player"
	player_car.car_name = Cars.selected_car_name
	player_car.controls_enabled = false
	
	scene.add_child(player_car)
	player_car.global_transform = track_node.get_node("SpawnPoint").global_transform
	_apply_player_color(player_car)

	# 2. СПАВН БОТОВ (AI)
	ai_cars.clear()
	var final_ai_paths = Cars.get_ai_paths_for_class(Cars.selected_class)
	if final_ai_paths.is_empty(): final_ai_paths = [player_car_path]
	
	final_ai_paths.shuffle()

	for i in range(min(7, final_ai_paths.size())):
		var ai_scene = load(final_ai_paths[i])
		var ai = ai_scene.instantiate() as CarController
		scene.add_child(ai)
		
		var spawn_node = track_node.get_node("AISpawnPoint" + str(i + 1))
		ai.global_transform = spawn_node.global_transform
		
		ai.is_ai = true
		ai.controls_enabled = false
		ai.driver_name = ai.ai_names[randi() % ai.ai_names.size()]
		
		# Определяем имя машины боту
		for car_name in Cars.car_scene_paths.keys():
			if Cars.car_scene_paths[car_name] == final_ai_paths[i]:
				ai.car_name = car_name
				break
		
		_apply_random_ai_color(ai)
		ai_cars.append(ai)

	await get_tree().process_frame

	# 3. НАСТРОЙКА ПУТЕЙ И ФИНИША
	var wp_root = scene.find_child("Waypoints", true, false)
	player_car.set_waypoints(wp_root)
	for ai in ai_cars: ai.set_waypoints(wp_root)

	# АВТО-ПОДКЛЮЧЕНИЕ ФИНИШНОЙ ЛИНИИ
	var lap_line = track_node.find_child("LapLine", true, false)
	if lap_line and lap_line is Area3D:
		if lap_line.body_entered.is_connected(register_lap):
			lap_line.body_entered.disconnect(register_lap)
		lap_line.body_entered.connect(register_lap)

	init_lap_system()

	# HUD
	hud.update_lap(1, total_laps)
	hud.update_position(ai_cars.size() + 1, ai_cars.size() + 1)

	# Запуск отсчета
	var start_node = scene.get_node("Start")
	if start_node:
		start_node.start_countdown(get_all_race_cars())

func on_countdown_finished():
	race_active = true
	player_car.controls_enabled = true
	for ai in ai_cars: ai.controls_enabled = true

func init_lap_system():
	car_laps.clear()
	lap_cooldown.clear()
	car_laps[player_car] = 0
	for ai in ai_cars:
		car_laps[ai] = 0

# ЭТА ФУНКЦИЯ ВЫЗЫВАЕТСЯ ТРИГГЕРОМ LAPLINE
func register_lap(body: Node) -> void:
	if not race_active: return

	# Ищем контроллер машины в родителе
	var car = body
	while car != null and not (car is CarController):
		car = car.get_parent()

	if car == null or not car_laps.has(car): return
	if lap_cooldown.get(car, false): return

	# Защита: засчитываем круг только если машина проехала хотя бы 50% вейпоинтов
	# (чтобы избежать багов с разворотом на финише)
	if car.current_wp < (car.waypoints.size() / 2):
		# Если это первый круг, это нормально, если нет - игнорируем
		if car_laps[car] > 0: return

	car_laps[car] += 1
	lap_cooldown[car] = true
	_start_lap_cooldown(car)

	# Обновляем HUD если это игрок
	if car == player_car:
		var display_lap = clamp(car_laps[car] + 1, 1, total_laps)
		hud.update_lap(display_lap, total_laps)
		
		# Проверка финиша
		if car_laps[car] >= total_laps:
			_end_race()

func _start_lap_cooldown(car):
	await get_tree().create_timer(2.0).timeout # Коддаун 2 сек, чтобы не засчитать круг дважды
	lap_cooldown[car] = false

func update_race() -> void:
	if not race_active or not is_instance_valid(player_car): return
	if player_car.waypoints.is_empty(): return

	hud.update_stopwatch(player_car.total_race_time)
	
	var player_pos = _calculate_position()
	hud.update_position(player_pos, ai_cars.size() + 1)

func _end_race() -> void:
	if not race_active: return
	race_active = false
	
	player_car.controls_enabled = false
	for ai in ai_cars: ai.controls_enabled = false

	var participants: Array = []
	var total_wp: int = player_car.waypoints.size()

	var cars_to_check := [player_car] + ai_cars
	for car in cars_to_check:
		var laps: int = car_laps.get(car, 0)
		var wp_index: int = _get_wp_index(car)
		var progress: int = (laps * total_wp) + wp_index
		var dist: float = _distance_to_next_wp_from_index(car, wp_index)

		participants.append({
			"name": car.driver_name,
			"car_name": car.car_name,
			"progress": progress,
			"dist": dist,
			"time": car.total_race_time,
			"finished": laps >= total_laps,
			"obj": car
		})

	# сортировка
	participants.sort_custom(func(a, b):
		# оба финишировали → по времени
		if a["finished"] and b["finished"]:
			return a["time"] < b["time"]

		# один финишировал → финишировавший выше
		if a["finished"] and not b["finished"]:
			return true
		if b["finished"] and not a["finished"]:
			return false

		# никто не финишировал → по прогрессу
		if a["progress"] != b["progress"]:
			return a["progress"] > b["progress"]

		# тайбрейк → по дистанции до следующего вейпоинта
		return a["dist"] < b["dist"]
	)

	RaceResults.clear()
	for p in participants:
		RaceResults.add_result(p["name"], p["car_name"], int(p["time"]))

	main_scene.show_finish(participants[0]["obj"] == player_car)
	hud.visible = false
	MusicManager.stop_music()
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


func _calculate_position() -> int:
	var total_wp = player_car.waypoints.size()
	var list = []
	for car in [player_car] + ai_cars:
		var progress = (car_laps.get(car, 0) * total_wp) + car.current_wp
		list.append({"car": car, "prog": progress})
	
	list.sort_custom(func(a, b): return a["prog"] > b["prog"])
	
	for i in range(list.size()):
		if list[i]["car"] == player_car: return i + 1
	return 1

func get_all_race_cars() -> Array:
	var arr = []
	if is_instance_valid(player_car): arr.append(player_car)
	for ai in ai_cars: 
		if is_instance_valid(ai): arr.append(ai)
	return arr

# Цвета (без изменений)
func _apply_player_color(car):
	var mesh = car.find_child("Body", true, false)
	if mesh: mesh.get_active_material(0).albedo_color = Cars.selected_color

func _apply_random_ai_color(car):
	var mesh = car.find_child("Body", true, false)
	if mesh:
		var mat = mesh.get_active_material(0).duplicate()
		mat.albedo_color = Color(randf(), randf(), randf())
		mesh.set_surface_override_material(0, mat)
