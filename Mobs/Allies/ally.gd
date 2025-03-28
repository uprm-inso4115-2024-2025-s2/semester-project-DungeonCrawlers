extends CharacterBody2D
@onready var foreground_bar = $AnimatedSprite2D/ForegroundBar
@onready var animated_sprite = $AnimatedSprite2D
@export var speed: float = 50  # Adjustable

var player = null
var move_direction = Vector2.ZERO

func _ready():
	animated_sprite.play("idle")
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta):
	if player:

		move_direction = (player.global_position - global_position).normalized()
		if (player.global_position.distance_to(global_position)) < 35:
			move_direction = Vector2.ZERO
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")

	velocity = move_direction * speed
	move_and_slide()

	if move_direction.x < 0:
		animated_sprite.flip_h = true
	elif move_direction.x > 0:
		animated_sprite.flip_h = false
