extends AnimatedSprite2D   

@export var normal_texture: Texture2D
@export var buff_texture:   Texture2D
@onready var player := get_tree().get_first_node_in_group("player")

func _ready() -> void:
	texture = normal_texture          # default look
	# Wire up to the player’s signals
	player.strength_buff_started.connect(_on_buff_start)
	player.strength_buff_ended.connect(_on_buff_end)

func _on_buff_start() -> void:
	texture = buff_texture            # or `modulate = buff_modulate`

func _on_buff_end() -> void:
	texture = normal_texture          # or `modulate = Color.WHITE`
