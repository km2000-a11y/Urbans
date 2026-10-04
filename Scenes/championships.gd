extends CanvasLayer

var selected_cup := ""

func _ready():
	MusicManager.play_menu_music()
	set_process_input(true)
	_update_button_states()
	$Control/Money.text = "$" + str(Cars.player_money)
	Localization.set_text($Control/CupInfo/ListBtn, "list")
	Localization.set_text($Control/CupInfo/GoBtn, "go")
	
# ============================================================
# INPUT HANDLING (DEBUG KEY)
# =====================================================================================
# INPUT HANDLING (DEBUG UNLOCK ACTION)
# ============================================================
# CAREER-AWARE CUP START
# ============================================================
# ============================================================
# INPUT HANDLING (DEBUG KEY)
# ============================================================
# ============================================================
# INPUT HANDLING (DEBUG KEY)
# ============================================================
func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:

		# G = reset career
		if event.keycode == KEY_G:
			ClubCups.debug_reset_career()
			_update_button_states()

		# M = unlock next cup
		if event.keycode == KEY_M:
			ClubCups.debug_complete_current_cup()
			_update_button_states()

		# N = unlock everything
		if event.keycode == KEY_N:
			ClubCups.debug_unlock_all_cups()
			_update_button_states()
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
	$Control/ScrollContainer/VBoxContainer/DieselMasters.disabled = not ClubCups.is_cup_unlocked("diesel_masters")

	$Control/ScrollContainer/VBoxContainer/AmericanThunder.disabled = not ClubCups.is_cup_unlocked("american_thunder")

	$Control/ScrollContainer/VBoxContainer/BritishInvasion.disabled = not ClubCups.is_cup_unlocked("british_invasion")

	$Control/ScrollContainer/VBoxContainer/GrandTouring.disabled = not ClubCups.is_cup_unlocked("grand_touring")
	$Control/ScrollContainer/VBoxContainer/BerkshireCup.disabled=not ClubCups.is_cup_unlocked("berkshire_cup")
	$Control/ScrollContainer/VBoxContainer/GentlemanRacers.disabled = not ClubCups.is_cup_unlocked("gentleman_racers")
	$Control/ScrollContainer/VBoxContainer/JapaneseCup.disabled = not ClubCups.is_cup_unlocked("japanese_cup")
	$Control/ScrollContainer/VBoxContainer/GermanCup.disabled = not ClubCups.is_cup_unlocked("german_cup")
	$Control/ScrollContainer/VBoxContainer/KestrelMax.disabled = not ClubCups.is_cup_unlocked("kestrel_max")
	$Control/ScrollContainer/VBoxContainer/V12Engines.disabled = not ClubCups.is_cup_unlocked("v12_engines")
	$Control/ScrollContainer/VBoxContainer/Supercars.disabled = not ClubCups.is_cup_unlocked("supercars")
	$Control/ScrollContainer/VBoxContainer/TrackCars.disabled = not ClubCups.is_cup_unlocked("track_cars")
	$Control/ScrollContainer/VBoxContainer/SportRacing.disabled = not ClubCups.is_cup_unlocked("sport_racing")
	$Control/ScrollContainer/VBoxContainer/UrbanPerformanceCars.disabled = not ClubCups.is_cup_unlocked("urban_performance_cars")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/Colossus", "colossus", "Colossus")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/UrbanPerformanceCars", "urban_performance_cars", "Urban Performance Cars")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/StreetTuners", "street_tuners", "Street Tuners")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/MuscleHustle", "muscle_hustle", "Muscle Hustle")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/V6Engines", "v6_engines", "V6 Engines")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/ZenithCompetition", "zenith_competition", "Zenith Competition")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/BusinessmanRacers", "businessman_racers", "Businessman Racers")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/SpeedsterTournament", "speedster_tournament", "Speedster Tournament")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/KuroCup", "kuro_cup", "Kuro Cup")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/AllWheelGrip", "all_wheel_grip", "All Wheel Grip")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/EisenachCup", "eisenach_cup", "Eisenach Cup")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/Under400HP", "under_400_hp", "Under 400 HP")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/StingrayCompetition", "stingray_competition", "Stingray Competition")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/SchroderCup", "schroder_cup", "Schroder Cup")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/DieselMasters", "diesel_masters", "Diesel Masters")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/AmericanThunder", "american_thunder", "American Thunder")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/BritishInvasion", "british_invasion", "British Invasion")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/GrandTouring", "grand_touring", "Grand Touring")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/BerkshireCup", "berkshire_cup", "Berkshire Cup")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/GentlemanRacers", "gentleman_racers", "Gentleman Racers")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/JapaneseCup", "japanese_cup", "Japanese Cup")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/GermanCup", "german_cup", "German Cup")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/KestrelMax", "kestrel_max", "Kestrel Max")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/V12Engines", "v12_engines", "V12 Engines")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/Supercars", "supercars", "Supercars")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/TrackCars", "track_cars", "Track Cars")
	_update_cup_text("Control/ScrollContainer/VBoxContainer/SportRacing", "sport_racing", "Sport Racing")
# ============================================================

func _on_colossus_pressed() -> void:
	_show_cup("colossus")

func _on_street_tuners_pressed() -> void:
	_show_cup("street_tuners")

func _on_muscle_hustle_pressed() -> void:
	_show_cup("muscle_hustle")

func _on_v_6_engines_pressed() -> void:
	_show_cup("v6_engines")

func _on_zenith_competition_pressed() -> void:
	_show_cup("zenith_competition")

func _on_businessman_racers_pressed() -> void:
	_show_cup("businessman_racers")

func _on_speedster_tournament_pressed() -> void:
	_show_cup("speedster_tournament")

func _on_kuro_cup_pressed() -> void:
	_show_cup("kuro_cup")

func _on_all_wheel_grip_pressed() -> void:
	_show_cup("all_wheel_grip")

func _on_eisenach_cup_pressed() -> void:
	_show_cup("eisenach_cup")

func _on_under_400hp_pressed() -> void:
	_show_cup("under_400_hp")

func _on_stingray_competition_pressed() -> void:
	_show_cup("stingray_competition")

func _on_schroder_cup_pressed() -> void:
	_show_cup("schroder_cup")

func _on_diesel_masters_pressed() -> void:
	_show_cup("diesel_masters")

func _on_american_thunder_pressed() -> void:
	_show_cup("american_thunder")

func _on_british_invasion_pressed() -> void:
	_show_cup("british_invasion")

func _on_grand_touring_pressed() -> void:
	_show_cup("grand_touring")

func _on_berkshire_cup_pressed() -> void:
	_show_cup("berkshire_cup")

func _on_gentleman_racers_pressed() -> void:
	_show_cup("gentleman_racers")

func _on_japanese_cup_pressed() -> void:
	_show_cup("japanese_cup")

func _on_german_cup_pressed() -> void:
	_show_cup("german_cup")

func _on_kestrel_max_pressed() -> void:
	_show_cup("kestrel_max")

func _on_v_12_engines_pressed() -> void:
	_show_cup("v12_engines")

func _on_supercars_pressed() -> void:
	_show_cup("supercars")

func _on_track_cars_pressed() -> void:
	_show_cup("track_cars")

func _on_sport_racing_pressed() -> void:
	_show_cup("sport_racing")

func _on_urban_performance_pressed() -> void:
	_show_cup("urban_performance_cars")

func _update_cup_text(button_path: String, cup_id: String, _base_text: String):
	var button = get_node(button_path)

	if ClubCups.is_cup_completed(cup_id):
		button.text = "🏆 " + Localization.translate(cup_id)
	else:
		button.text = Localization.translate(cup_id)
func _show_cup_info(cup_id: String):
	selected_cup = cup_id

	$Control/CupInfo.visible = true
	$Control/CupInfo/Label.text = ClubCups.get_cup_details_text(cup_id)
func _show_cup(cup_id: String):
	selected_cup = cup_id

	$Control/CupInfo.visible = true

	var text := ""

	text += Localization.translate(cup_id)
	text += "\n\n"

	text += Localization.translate("reward_car")
	text += ": "

	if ClubCups.cup_rewards.has(cup_id):
		text += ClubCups.cup_rewards[cup_id]
	else:
		text += "-"

	text += "\n"

	text += Localization.translate("cash_reward")
	text += ": $"
	text += str(ClubCups.cash_rewards.get(cup_id, 0))

	$Control/CupInfo/Label.text = text
func _on_list_btn_pressed() -> void:
	var text := ""

	text += Localization.translate("reward_car")
	text += ": "
	text += ClubCups.cup_rewards.get(selected_cup, "None")

	text += "\n"

	text += Localization.translate("cash_reward")
	text += ": $"
	text += str(ClubCups.cash_rewards.get(selected_cup, 0))

	text += "\n\n"

	text += Localization.translate("eligible_cars")
	text += ":\n"

	for car in ClubCups.get_available_cars(selected_cup):
		text += "• " + car + "\n"

	$Control/CupInfo/Label.text = text
func _on_go_pressed() -> void:
	$Control/CupInfo.visible = false

	GameMode.game_mode = "Club Cups"
	ChampionshipState.active_cup = selected_cup
	ChampionshipState.championship_mode = true

	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")
func _on_dealership_pressed() -> void:
	# Enable dealership mode globally
	Cars.enable_dealership_mode()

	# Reset championship state so dealership is clean
	ChampionshipState.reset()

	# Go to Car Select scene in dealership mode
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")
func _on_back_btn_pressed():
	ChampionshipState.reset()
	GameMode.game_mode = ""
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
