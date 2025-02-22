extends CharacterBody2D

@export var speed = 50


func _input(event):
	pass

func _physics_process(delta):
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		position.x += speed*delta
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		position.y -= speed*delta
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		position.y += speed*delta
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		position.x -= speed*delta
