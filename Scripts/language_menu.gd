extends CanvasLayer

func _on_english_pressed() -> void:
	Localization.set_language("en")

func _on_french_pressed() -> void:
	Localization.set_language("fr")

func _on_german_pressed() -> void:
	Localization.set_language("de")

func _on_russian_pressed() -> void:
	Localization.set_language("ru")

func _on_serbo_croatian_pressed() -> void:
	Localization.set_language("sh")

func _on_turkish_pressed() -> void:
	Localization.set_language("tr")

func _on_back_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
