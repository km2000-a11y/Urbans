extends CanvasLayer

func _process(delta: float) -> void:
	$Control/VBoxContainer/Money.text = Localization.translate("money") + ": $" + str(Cars.player_money)
	
func _on_dealership_pressed() -> void:
	# Enable dealership mode globally
	Cars.enable_dealership_mode()

	# Reset championship state so dealership is clean
	ChampionshipState.reset()

	# Go to Car Select scene in dealership mode
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")

func _on_car_dealership_pressed() -> void:
	Cars.enable_dealership_mode()

	# Reset championship state so dealership is clean
	ChampionshipState.reset()

	# Go to Car Select scene in dealership mode
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")



func _on_championships_pressed() -> void:
	GameMode.game_mode=="Club Cups"
	
	get_tree().change_scene_to_file("res://Scenes/championships.tscn")


func _on_garage_pressed() -> void:
	Cars.garage_mode = true
	Cars.dealership_mode = false
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")


func _on_back_btn_pressed() -> void:
	ChampionshipState.reset()
	GameMode.game_mode = ""
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
