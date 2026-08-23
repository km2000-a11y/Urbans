extends CanvasLayer

func _start_race_with_track(track_name: String):
	RoadChallengeState.active_track = track_name
	TrackName.track_name = track_name

	# Works for single player AND LAN
	get_tree().change_scene_to_file("res://main.tscn")


func _on_bogota_airport_pressed():
	_start_race_with_track("BogotaAirport")

func _on_chernobyl_pressed():
	_start_race_with_track("Chernobyl")

func _on_abu_dhabi_pressed():
	_start_race_with_track("AbuDhabi")

func _on_split_pressed():
	_start_race_with_track("Split")
