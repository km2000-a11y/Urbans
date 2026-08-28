extends CanvasLayer

@onready var title_label: Label = $Control/Panel/TitleLabel
@onready var entries: VBoxContainer = $Control/VBoxContainer
@onready var retry_button: Button = $Control/RetryBtn
@onready var quit_button: Button = $Control/QuitBtn

func show_results(player_won: bool) -> void:
	# Title
	if player_won:
		title_label.text = "YOU WIN!"
	else:
		title_label.text = "YOU LOSE!"

	# Road Challenge extra text
	if GameMode.game_mode == "Road Challenge":
		var group: String = RoadChallengeState.active_group
		var done: int = RoadChallengeSave.progress[group]
		var left: int = 5 - done

		if left > 0:
			title_label.text += "\nRaces left: %d / 5" % left
		else:
			title_label.text += "\nChallenge Complete!"

	# Clear old entries
	for child in entries.get_children():
		child.queue_free()

	# Get results
	var results: Array = RaceResults.results.duplicate()

	# ⭐ FIX: Sort results by time (ascending)
	results.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
		return a["time"] < b["time"]
	)

	# Display sorted results
	for i: int in results.size():
		var r: Dictionary = results[i]
		var line := Label.new()
		line.text = "%d. %s — %s — %s" % [
			i + 1,
			r["name"],
			r["car"],
			_format_time(r["time"])
		]
		entries.add_child(line)

	# Club Cups reward
	if player_won and GameMode.game_mode == "Club Cups":
		Cars.add_money(5000)
		var money_label: Label = $Control/Panel/MoneyLabel
		money_label.text = "Reward: $5000\nBalance: $" + str(Cars.player_money)

	visible = true


func _format_time(ms: int) -> String:
	var total_seconds: float = ms / 1000.0
	var minutes: int = int(total_seconds / 60)
	var seconds: float = total_seconds - minutes * 60
	return "%02d:%05.2f" % [minutes, seconds]


func _on_retry_btn_pressed() -> void:
	reset()
	get_tree().reload_current_scene()


func _on_quit_btn_pressed() -> void:
	reset()
	if GameMode.game_mode == "Road Challenge":
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func reset() -> void:
	title_label.text = ""

	for child in entries.get_children():
		child.queue_free()

	visible = false
