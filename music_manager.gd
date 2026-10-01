extends Node

var player: AudioStreamPlayer
var current_track_index := 0
var user_selected_track := false
var current_race_path := ""

var race_tracks := [
	"res://Songs/Electro_High.mp3",
	"res://Songs/Hypnotic Groove.mp3",
	"res://Songs/Indie_Tiger.mp3",
	"res://Songs/Intensity.mp3",
	"res://Songs/Retro Hand-Drum Groove.mp3",
	"res://Songs/Smooth_Mambo.mp3",
	"res://Songs/Industrial_Madness.mp3",
	"res://Songs/Urban_Bass.mp3"
]

func _ready() -> void:
	player = AudioStreamPlayer.new()
	add_child(player)
	player.volume_db = -6

	randomize()

func play_menu_music() -> void:
	var path := "res://Songs/menu_track.mp3"

	if player.stream and player.stream.resource_path == path and player.playing:
		return

	player.stream = load(path)
	player.play()

func play_race_music() -> void:

	# RANDOM MODE
	if not user_selected_track:

		current_track_index = randi() % race_tracks.size()
		current_race_path = race_tracks[current_track_index]

		player.stream = load(current_race_path)
		player.play()
		return

	# PLAYER CHOSE A TRACK
	if player.stream and player.stream.resource_path == current_race_path and player.playing:
		return

	player.stream = load(current_race_path)
	player.play()
func play_jukebox_track(path: String) -> void:
	user_selected_track = true
	current_race_path = path

	player.stream = load(path)
	player.play()

func enable_random_music() -> void:
	user_selected_track = false

func stop_music() -> void:
	player.stop()

func start_countdown() -> void:
	player.stop()
	player.stream = null
func next_track() -> void:

	user_selected_track = true

	current_track_index += 1

	if current_track_index >= race_tracks.size():
		current_track_index = 0

	current_race_path = race_tracks[current_track_index]

	player.stream = load(current_race_path)
	player.play()
func previous_track() -> void:

	user_selected_track = true

	current_track_index -= 1

	if current_track_index < 0:
		current_track_index = race_tracks.size() - 1

	current_race_path = race_tracks[current_track_index]

	player.stream = load(current_race_path)
	player.play()
