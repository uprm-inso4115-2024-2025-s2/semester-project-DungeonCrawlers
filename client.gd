extends Node2D

const SERVER_IP = "172.23.155.142"  # MACOS: ipconfig getifaddr en0 / LINUX: hostname -I
const SERVER_PORT = 8910

var peer: ENetMultiplayerPeer

func _ready():
    peer = ENetMultiplayerPeer.new()
    var result = peer.create_client(SERVER_IP, SERVER_PORT)
    if result != OK:
        push_error("Failed to create client: " + str(result))
    else:
        multiplayer.multiplayer_peer = peer
        print("Attempting to connect to server at " + SERVER_IP + ":" + str(SERVER_PORT))
        multiplayer.connected_to_server.connect(_on_connected)
        multiplayer.connection_failed.connect(_on_connection_failed)
        multiplayer.server_disconnected.connect(_on_disconnected)

func _on_connected():
    print("Connected to server!")

func _on_connection_failed():
    print("Connection to server failed.")

func _on_disconnected():
    print("Disconnected from server.")

@rpc("unreliable", "call_local")
func update_player_position(player_id: int, new_position: Vector2):
    if player_id == multiplayer.get_unique_id():
        return  # Ignore our own position updates (handled locally)

    var player = get_node_or_null("Player" + str(player_id))
    if player:
        player.global_position = new_position  # Apply position update from server
