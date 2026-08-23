extends CanvasLayer

func _ready():
	MusicManager.play_menu_music()

func _on_road_challenge_pressed() -> void:
	GameMode.game_mode = "Road Challenge"
	Cars.selected_class = ""   # ⭐ THIS is the missing line
	Cars.selected_car_name = ""
	Cars.manual_class_clear = true
	Modes.mode = "Normal Race"
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")

func _on_free_race_pressed() -> void:
	GameMode.game_mode = "Free Race"
	Cars.selected_class = ""   # ⭐ And here too
	Cars.selected_car_name = ""
	Cars.manual_class_clear = true
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")

func _on_club_cups_pressed() -> void:
	GameMode.game_mode = "Club Cups"
	get_tree().change_scene_to_file("res://Scenes/championships.tscn")


func _on_multi_device_pressed() -> void:
	GameMode.game_mode = "Multi-Device"
	$LANUI.show()
	$Control.hide()
