extends CanvasLayer

func _ready():
	MusicManager.play_menu_music()

func _on_colossus_pressed() -> void:
	GameMode.game_mode = "Club Cups"
	ChampionshipState.active_cup = "colossus"
	ChampionshipState.championship_mode = true

	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_street_tuners_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="street_tuners"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_muscle_hustle_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="muscle_hustle"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_v_6_engines_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="v6_engines"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_back_btn_pressed():
	ChampionshipState.reset()
	GameMode.game_mode = ""
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_zenith_competition_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="zenith_competition"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_businessman_racers_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="businessman_racers"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_speedster_tournament_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="speedster_tournament"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_kuro_cup_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="kuro_cup"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_all_wheel_grip_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="all_wheel_grip"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_eisenach_cup_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="eisenach_cup"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_under_400hp_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="under_400_hp"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_stingray_competition_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="stingray_competition"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_schroder_cup_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="schroder_cup"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_gentleman_racers_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="gentleman_racers"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_japanese_cup_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="japanese_cup"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")



func _on_german_cup_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="german_cup"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_kestrel_max_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="kestrel_max"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_v_12_engines_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="v12_engines"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_supercars_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="supercars"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_track_cars_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="track_cars"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")
