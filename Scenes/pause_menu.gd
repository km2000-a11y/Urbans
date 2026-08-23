extends CanvasLayer

var is_paused:=false
var volume:=80



func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	update_volume_label()
	apply_volume()

	
func toggle_pause():
	is_paused=!is_paused
	get_tree().paused=is_paused
	visible=is_paused
	
func _on_resume_btn_pressed() -> void:
	toggle_pause()
	

func _on_retry_btn_pressed() -> void:
	get_tree().paused = false  

	# NORMAL RACE
	if Modes.mode == "Normal Race":
		if NormalRaceManager:
			NormalRaceManager.race_active = false  
			NormalRaceManager.player_car = null  
			NormalRaceManager.ai_cars.clear()  
		get_tree().reload_current_scene()
		return

	# DUEL
	if Modes.mode == "Duel":
		if DuelManager:
			DuelManager.duel_active = false  
			DuelManager.player_car = null  
			DuelManager.ai_car = null  
		get_tree().reload_current_scene()
		return

	# ELIMINATION
	if Modes.mode == "Elimination":
		if EliminationManager:
			EliminationManager.race_active = false  
			EliminationManager.player_car = null  
			EliminationManager.ai_cars.clear()  
		get_tree().reload_current_scene()
		return

	# COP CHASE
	if Modes.mode == "Cop Chase":
		if CopChaseManager:
			CopChaseManager.chase_active = false  
			CopChaseManager.player_car = null  
			CopChaseManager.ai_cars.clear()  
		get_tree().reload_current_scene()
		return

	# ANY OTHER MODE (Free Drive, Radar Race, etc.)
	get_tree().reload_current_scene()


	
func _on_quit_btn_pressed() -> void:
	get_tree().paused=false
	ChampionshipState.reset()
	GameMode.game_mode = ""

	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	

func _on_vol_up_btn_pressed() -> void:
	volume=clamp(volume+5,0,100)
	update_volume_label()
	apply_volume()
	
func _on_vol_down_btn_pressed() -> void:
	volume=clamp(volume-5,0,100)
	update_volume_label()
	apply_volume()
	
func update_volume_label():
	$Control/Panel/VolumeLabel.text="Volume: %d%%"%volume
	
func apply_volume():
	var linear=float(volume)/100.0
	AudioServer.set_bus_volume_db(0, linear_to_db(linear))
