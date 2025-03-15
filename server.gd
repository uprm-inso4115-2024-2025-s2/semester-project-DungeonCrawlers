extends Node

const PORT = 8910

var peer: ENetMultiplayerPeer

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

func _on_peer_disconnected(id):
	print("Player disconnected: ", id)
