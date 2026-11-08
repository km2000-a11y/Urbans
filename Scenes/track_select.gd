extends CanvasLayer

func _start_race_with_track(track_name: String) -> void:
	RoadChallengeState.active_track = track_name

	if GameMode.game_mode == "Multi-Device":
		var my_color: Color = Cars.selected_color

		# Сообщаем всем игрокам выбранный цвет.
		LanManager.rpc(
			"sync_my_color",
			my_color.r,
			my_color.g,
			my_color.b
		)

		# Трассу запускает только хост.
		if multiplayer.is_server():
			LanManager.rpc("sync_track_and_start", track_name)
	else:
		TrackName.track_name = track_name
		get_tree().change_scene_to_file("res://main.tscn")

func _on_bogota_airport_pressed() -> void:
	_start_race_with_track("BogotaAirport")

func _on_chernobyl_pressed() -> void:
	_start_race_with_track("Chernobyl")

func _on_abu_dhabi_pressed() -> void:
	_start_race_with_track("AbuDhabi")

func _on_split_pressed() -> void:
	_start_race_with_track("Split")

func _on_new_york_pressed() -> void:
	_start_race_with_track("NewYork")

func _on_las_vegas_pressed() -> void:
	_start_race_with_track("LasVegas")

func _on_back_btn_pressed() -> void:
	if Modes.mode == "Cop Chase":
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/car_select.tscn")
