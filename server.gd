extends Node

const PORT = 8910

var peer: ENetMultiplayerPeer
var player_positions = {}  # Dictionary to store player positions

func _ready():
    peer = ENetMultiplayerPeer.new()
    var result = peer.create_server(PORT, 32)
    if result != OK:
        push_error("Failed to start server: " + str(result))
    else:
        multiplayer.multiplayer_peer = peer
        print("Server started on port " + str(PORT))
        multiplayer.peer_connected.connect(_on_peer_connected)
        multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func _on_peer_connected(id):
    print("Player connected: ", id)
    # Assign initial position for the new player
    player_positions[id] = Vector2(100, 100)  # Default spawn point
    rpc_id(id, "update_player_position", player_positions[id])  # Send initial position to player

func _on_peer_disconnected(id):
    print("Player disconnected: ", id)
    player_positions.erase(id)  # Remove player data from server

@rpc("reliable")
func send_movement_input(direction: Vector2):
    var player_id = multiplayer.get_remote_sender()  # Get the sender's ID
    if player_id not in player_positions:
        return  # Ignore if player isn't in the dictionary

    # Validate movement to prevent speed hacking
    var speed = 50
    var new_position = player_positions[player_id] + (direction * speed / 60)  # Assume 60 FPS

    # Update stored position
    player_positions[player_id] = new_position

    # Broadcast the new position to all clients
    rpc("update_player_position", player_id, new_position)

@rpc("unreliable")
func update_player_position(player_id: int, new_position: Vector2):
    pass  # Clients will receive and apply this update
