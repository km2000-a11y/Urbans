extends CanvasLayer

@onready var title_label := $Control/Panel/TitleLabel
@onready var retry_button := $Control/Panel/RetryBtn
@onready var quit_button := $Control/Panel/QuitBtn

func show_results(player_won: bool):
	var text := ""

	if player_won:
		text = "YOU WIN!"
	else:
		text = "YOU LOSE!"

	# ROAD CHALLENGE PROGRESS
	if GameMode.game_mode == "Road Challenge":
		var group := RoadChallengeState.active_group
		var done :int = RoadChallengeSave.progress[group]
		var left := 5 - done

		if left > 0:
			text += "\nRaces left: %d / 5" % left
		else:
			text += "\nChallenge Complete!"

	title_label.text = text
	visible = true

	# ⭐ CLUB CUPS REWARD BLOCK
	if player_won and GameMode.game_mode == "Club Cups":
		Cars.add_money(6000)
		if has_node("Control/Panel/MoneyLabel"):
			var money_label := $Control/Panel/MoneyLabel
			money_label.text = "Reward: $6000\nBalance: $" + str(Cars.player_money)
			money_label.visible = true

		# Optional: also show RewardLabel if present
		if has_node("Control/Panel/RewardLabel"):
			$Control/Panel/RewardLabel.text = "+ $6000 Reward"
			$Control/Panel/RewardLabel.visible = true


func _on_retry_btn_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quit_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")

func show_reward(text: String):
	if has_node("Control/Panel/RewardLabel"):
		$Control/Panel/RewardLabel.text = text
		$Control/Panel/RewardLabel.visible = true
