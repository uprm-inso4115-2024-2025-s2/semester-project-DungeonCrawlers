extends CanvasLayer


@export var player : CharacterBody2D
@export var tileMap : TileMap
@onready var sub_viewport = $SubViewportContainer/SubViewport
var miniMapPlayer

func _ready():
	miniMapPlayer = player.duplicate()

	#sub_viewport.add_child(tileMap.duplicate())
	#sub_viewport.add_child(miniMapPlayer)

func _process(delta):
	miniMapPlayer.position = player.position
