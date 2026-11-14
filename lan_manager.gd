extends Node

signal status_changed(message: String)

const PORT := 9000
const MAX_CLIENTS := 3

var peer: ENetMultiplayerPeer
var is_host := false
var synced_track_name := ""
var player_colors: Dictionary = {}

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

func start_host() -> void:
	is_host = true
	peer = ENetMultiplayerPeer.new()

	var error := peer.create_server(PORT, MAX_CLIENTS)
	if error != OK:
		status_changed.emit("Failed to start server: %s" % error_string(error))
		return

	multiplayer.multiplayer_peer = peer
	
	# Host stores its own color under its unique ID (1)
	player_colors[multiplayer.get_unique_id()] = Color(1.0, 0.35, 0.31) # Default Imola Red or whatever you prefer
	status_changed.emit("Game started. Expecting players...")

func join_host(ip: String) -> void:
	is_host = false
	var address := ip.strip_edges()

	if address.is_empty():
		status_changed.emit("Enter IP of host to join game")
		return

	peer = ENetMultiplayerPeer.new()
	var error := peer.create_client(address, PORT)
	if error != OK:
		status_changed.emit("Failed to start game: %s" % error_string(error))
		return

	multiplayer.multiplayer_peer = peer
	status_changed.emit("Connecting to %s..." % address)

func _on_peer_connected(id: int) -> void:
	if not is_host:
		return

	status_changed.emit("Player %d connected" % id)
	
	# Send already connected players' colors to the new peer so they stay in sync
	for p_id in player_colors:
		_sync_color_to_peer.rpc_id(id, p_id, player_colors[p_id].r, player_colors[p_id].g, player_colors[p_id].b)

	call_deferred("_host_start_car_select", id)

func _on_peer_disconnected(id: int) -> void:
	status_changed.emit("Player %d connected" % id)
	player_colors.erase(id)

func _on_connected_to_server() -> void:
	status_changed.emit("Connected to host")

func _on_connection_failed() -> void:
	status_changed.emit("Couldnt connect")

func _on_server_disconnected() -> void:
	status_changed.emit("Connection lost with host")

func _host_start_car_select(id: int) -> void:
	if not is_host:
		return

	var current_scene := get_tree().current_scene
	if current_scene == null or current_scene.scene_file_path != "res://Scenes/car_select.tscn":
		get_tree().change_scene_to_file("res://Scenes/car_select.tscn")

	rpc_id(id, "client_go_to_car_select")

@rpc("authority", "reliable")
func client_go_to_car_select() -> void:
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")

# Called by any client or host when they change their color in the menu
@rpc("any_peer", "call_local", "reliable")
func sync_my_color(r: float, g: float, b: float) -> void:
	var sender_id := multiplayer.get_remote_sender_id()
	if sender_id == 0:
		sender_id = multiplayer.get_unique_id()

	player_colors[sender_id] = Color(r, g, b)

	# If we are server, broadcast this update to everyone else
	if multiplayer.is_server():
		_broadcast_color.rpc(sender_id, r, g, b)

@rpc("authority", "call_local", "reliable")
func _broadcast_color(id: int, r: float, g: float, b: float) -> void:
	player_colors[id] = Color(r, g, b)

@rpc("authority", "reliable")
func _sync_color_to_peer(id: int, r: float, g: float, b: float) -> void:
	player_colors[id] = Color(r, g, b)

@rpc("authority", "call_local", "reliable")
func sync_track_and_start(track_name: String) -> void:
	synced_track_name = track_name
	TrackName.track_name = track_name
	get_tree().change_scene_to_file("res://main.tscn")
