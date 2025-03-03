extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
var speed = 50
var target = null
var move_direction = Vector2.ZERO

func _ready():
	animated_sprite.play("idle")
	# Set a random direction initially
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func _physics_process(delta):
	# Simple movement logic - can be enhanced
	if target:
		move_direction = global_position.direction_to(target.global_position)
		animated_sprite.play("run")
	else:
		# Move in the random direction or idle sometimes
		if randf() < 0.01:  # Small chance to change direction
			move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		
		# Small chance to stop and idle
		if randf() < 0.02:
			move_direction = Vector2.ZERO
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	
	velocity = move_direction * speed
	move_and_slide()
	
	# Flip sprite based on movement direction
	if move_direction.x < 0:
		animated_sprite.flip_h = true
	elif move_direction.x > 0:
		animated_sprite.flip_h = false

# You can add more functions for ally behavior here
func set_target(new_target):
	target = new_target
