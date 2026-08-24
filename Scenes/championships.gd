extends CanvasLayer

func _ready():
	MusicManager.play_menu_music()
	set_process_input(true)
	_update_button_states()

# ============================================================
# INPUT HANDLING (DEBUG KEY)
# =====================================================================================
# INPUT HANDLING (DEBUG UNLOCK ACTION)
# ============================================================
func _input(event):
	if event.is_action_pressed("champ_unlock"):
		var current = ClubCups.get_current_cup()
		ClubCups.complete_cup(current)
		print("Debug: advanced career, unlocked next cup")
		_update_button_states()
	if $Control.has_node("Money"):
		$Control/Money.text = "Balance: $" + str(Cars.player_money)

# ============================================================
# CAREER-AWARE CUP START
# ============================================================


# ============================================================
# CAREER-AWARE CUP START
# ============================================================
func _start_cup(cup_id: String) -> void:
	if ClubCups.is_cup_unlocked(cup_id):
		GameMode.game_mode = "Club Cups"
		ChampionshipState.active_cup = cup_id
		ChampionshipState.championship_mode = true
		get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")
	else:
		print("Cup locked: ", cup_id)

# ============================================================
# BUTTON STATE MANAGEMENT (EXPLICIT PATHS)
# ============================================================
func _update_button_states():
	$Control/ScrollContainer/VBoxContainer/Colossus.disabled = not ClubCups.is_cup_unlocked("colossus")
	$Control/ScrollContainer/VBoxContainer/StreetTuners.disabled = not ClubCups.is_cup_unlocked("street_tuners")
	$Control/ScrollContainer/VBoxContainer/MuscleHustle.disabled = not ClubCups.is_cup_unlocked("muscle_hustle")
	$Control/ScrollContainer/VBoxContainer/V6Engines.disabled = not ClubCups.is_cup_unlocked("v6_engines")
	$Control/ScrollContainer/VBoxContainer/ZenithCompetition.disabled = not ClubCups.is_cup_unlocked("zenith_competition")
	$Control/ScrollContainer/VBoxContainer/BusinessmanRacers.disabled = not ClubCups.is_cup_unlocked("businessman_racers")
	$Control/ScrollContainer/VBoxContainer/SpeedsterTournament.disabled = not ClubCups.is_cup_unlocked("speedster_tournament")
	$Control/ScrollContainer/VBoxContainer/KuroCup.disabled = not ClubCups.is_cup_unlocked("kuro_cup")
	$Control/ScrollContainer/VBoxContainer/AllWheelGrip.disabled = not ClubCups.is_cup_unlocked("all_wheel_grip")
	$Control/ScrollContainer/VBoxContainer/EisenachCup.disabled = not ClubCups.is_cup_unlocked("eisenach_cup")
	$Control/ScrollContainer/VBoxContainer/Under400HP.disabled = not ClubCups.is_cup_unlocked("under_400_hp")
	$Control/ScrollContainer/VBoxContainer/StingrayCompetition.disabled = not ClubCups.is_cup_unlocked("stingray_competition")
	$Control/ScrollContainer/VBoxContainer/SchroderCup.disabled = not ClubCups.is_cup_unlocked("schroder_cup")
	$Control/ScrollContainer/VBoxContainer/GentlemanRacers.disabled = not ClubCups.is_cup_unlocked("gentleman_racers")
	$Control/ScrollContainer/VBoxContainer/JapaneseCup.disabled = not ClubCups.is_cup_unlocked("japanese_cup")
	$Control/ScrollContainer/VBoxContainer/GermanCup.disabled = not ClubCups.is_cup_unlocked("german_cup")
	$Control/ScrollContainer/VBoxContainer/KestrelMax.disabled = not ClubCups.is_cup_unlocked("kestrel_max")
	$Control/ScrollContainer/VBoxContainer/V12Engines.disabled = not ClubCups.is_cup_unlocked("v12_engines")
	$Control/ScrollContainer/VBoxContainer/Supercars.disabled = not ClubCups.is_cup_unlocked("supercars")
	$Control/ScrollContainer/VBoxContainer/TrackCars.disabled = not ClubCups.is_cup_unlocked("track_cars")

# ============================================================

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


func _on_sport_racing_pressed() -> void:
	GameMode.game_mode="Club Cups"
	ChampionshipState.active_cup="sport_racing"
	ChampionshipState.championship_mode=true
	
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func _on_dealership_pressed() -> void:
	# Enable dealership mode globally
	Cars.enable_dealership_mode()
	
	# Reset championship state so dealership is clean
	ChampionshipState.reset()


	# Go to Car Select scene in dealership mode
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")
