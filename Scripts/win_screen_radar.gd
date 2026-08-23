extends CanvasLayer

func show_win(success: bool):
	var text := ""

	if success:
		text = "YOU WIN!"
	else:
		text = "YOU LOSE!"

	# ROAD CHALLENGE PROGRESS
	if GameMode.game_mode == "Road Challenge":
		var group := RoadChallengeState.active_group
		var done :int= RoadChallengeSave.progress[group]

	# ⭐ Club Cups money reward
	if success and GameMode.game_mode == "Club Cups":
		Cars.add_money(5000)
		var money_label = $Control/Panel/MoneyLabel
		money_label.text = "Reward: $5000\nBalance: $" + str(Cars.player_money)

	$Control/Panel/VBoxContainer/Label_Title.text = text
	visible = true


func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")
