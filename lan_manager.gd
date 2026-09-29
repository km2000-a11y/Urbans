extends Node

var peer: ENetMultiplayerPeer
var is_host := false

signal status_changed(msg)

const PORT := 9000
const MAX_PLAYERS := 4

var synced_track_name: String = ""
var player_colors: Dictionary = {}

@rpc("any_peer", "call_local", "reliable")
func sync_my_color(r: float, g: float, b: float):
	var sender_id := multiplayer.get_remote_sender_id()
	if sender_id == 0:
		sender_id = multiplayer.get_unique_id()
	player_colors[sender_id] = Color(r, g, b)
func start_host():
	is_host = true
	peer = ENetMultiplayerPeer.new()

	var result := peer.create_server(PORT, MAX_PLAYERS)
	print("Host result: ", result)

	if result != OK:
		emit_signal("status_changed", "Failed to start host")
		return

	multiplayer.multiplayer_peer = peer
	emit_signal("status_changed", "Hosting...")

	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func join_host(ip: String):
	is_host = false
	peer = ENetMultiplayerPeer.new()

	var result := peer.create_client(ip, PORT)
	print("Join result: ", result)

	if result != OK:
		emit_signal("status_changed", "Failed to connect")
		return

	multiplayer.multiplayer_peer = peer
	emit_signal("status_changed", "Connecting...")

	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func _on_peer_connected(id):
	if is_host:
		print("Client joined:", id)
		emit_signal("status_changed", "Player %d joined" % id)
		call_deferred("_host_start_car_select", id)
	else:
		print("Connected to host")
		emit_signal("status_changed", "Connected to host")

@rpc("authority")
func client_go_to_car_select():
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")

func _on_peer_disconnected(id):
	if is_host:
		emit_signal("status_changed", "Player %d left" % id)
	else:
		emit_signal("status_changed", "Disconnected from host")

func _host_start_car_select(id):
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")
	rpc_id(id, "client_go_to_car_select")

@rpc("authority", "call_local", "reliable")
func sync_track_and_start(track_name: String):
	print("MY ID: ", multiplayer.get_unique_id(), " | Трасса: ", track_name)
	TrackName.track_name = track_name
	get_tree().change_scene_to_file("res://main.tscn")
