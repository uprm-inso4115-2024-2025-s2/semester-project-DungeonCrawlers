extends CanvasLayer

@export var player: CharacterBody2D
@export var tile_map: TileMap

@onready var sub_viewport = $SubViewportContainer/SubViewport

var mini_map_tilemap
var mini_map_player

func _ready():
	# Duplicate the TileMap correctly
	mini_map_tilemap = tile_map.duplicate()  # Ensure duplication is allowed
	mini_map_tilemap.name = "MiniMapTileMap"
	mini_map_tilemap.scale = Vector2(0.2, 0.2)  # Scale down for the MiniMap

	# Duplicate the player for the MiniMap
	mini_map_player = player.duplicate()
	mini_map_player.name = "MiniMapPlayer"

	# Remove collisions and unnecessary properties from the MiniMap version
	mini_map_tilemap.set_layer_enabled(0, true)  # Ensure the MiniMap layer is visible
	mini_map_tilemap.hide()
	
	# Add the duplicated TileMap and player icon to the SubViewport
	sub_viewport.add_child(mini_map_tilemap)
	sub_viewport.add_child(mini_map_player)

func _process(delta):
	# Update the MiniMap player position relative to the original player
	mini_map_player.position = player.position * 0.2  # Adjust scaling to match MiniMap
