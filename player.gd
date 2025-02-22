extends CharacterBody2D

@export var speed = 50

@onready var target = position

func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 1:
		move_and_slide()
	else:
		velocity = Vector2.ZERO  # Stop movement when close to the target
	
