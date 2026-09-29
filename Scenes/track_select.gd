extends CanvasLayer

func _start_race_with_track(track_name: String):
	if GameMode.game_mode == "Multi-Device":
		# Сначала синхронизируем цвет со всеми
		var c := Cars.selected_color
		LanManager.rpc("sync_my_color", c.r, c.g, c.b)
		# Сохраняем свой цвет тоже
		LanManager.player_colors[multiplayer.get_unique_id()] = c

		if multiplayer.is_server():
			LanManager.rpc("sync_track_and_start", track_name)
	else:
		TrackName.track_name = track_name
		get_tree().change_scene_to_file("res://main.tscn")


func _on_bogota_airport_pressed():
	_start_race_with_track("BogotaAirport")	

func _on_chernobyl_pressed():
	_start_race_with_track("Chernobyl")

func _on_abu_dhabi_pressed():
	_start_race_with_track("AbuDhabi")

func _on_split_pressed():
	_start_race_with_track("Split")


func _on_back_btn_pressed() -> void:
	if Modes.mode=="Cop Chase":
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

	else: 
		get_tree().change_scene_to_file("res://Scenes/car_select.tscn")
