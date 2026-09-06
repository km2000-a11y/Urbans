extends CanvasLayer

func _on_english_pressed() -> void:
	Localization.set_language("en")
	UiTheme.apply_language_font(Localization.LANG)
	Localization.save_language()

func _on_french_pressed() -> void:
	Localization.set_language("fr")
	UiTheme.apply_language_font(Localization.LANG)
	Localization.save_language()


func _on_german_pressed() -> void:
	Localization.set_language("de")
	UiTheme.apply_language_font(Localization.LANG)
	Localization.save_language()
	

func _on_russian_pressed() -> void:
	Localization.set_language("ru")
	UiTheme.apply_language_font(Localization.LANG)
	Localization.save_language()
  

func _on_serbo_croatian_pressed() -> void:
	Localization.set_language("sh")
	UiTheme.apply_language_font(Localization.LANG)
	Localization.save_language()


func _on_turkish_pressed() -> void:
	Localization.set_language("tr")
	UiTheme.apply_language_font(Localization.LANG)
	Localization.save_language()
  




func _on_back_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
