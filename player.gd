extends CharacterBody2D

@export var speed = 50
@export var attack_damage = 10
@export var attack_offset = 10 

@onready var target = position
@onready var attack_sprite = $AttackSprite
@onready var attack_area = $AttackSprite/AttackArea  

var attacking = false
var is_moving = false
var last_direction = Vector2.RIGHT 

func _input(event):

	if event.is_action_pressed("attack") and not attacking:
		start_attack()
func _physics_process(delta):
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		position.x += speed*delta
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		position.y -= speed*delta
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		position.y += speed*delta
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		position.x -= speed*delta

	move_and_slide()
func start_attack():
	attacking = true  
	attack_sprite.visible = true  
	attack_sprite.scale = Vector2(1, 1)  

	
	attack_sprite.position = last_direction * attack_offset

	
	if abs(last_direction.x) > abs(last_direction.y):  
		attack_sprite.rotation_degrees = 0  
	else:  
		attack_sprite.rotation_degrees = 90  

	if attack_sprite.sprite_frames and attack_sprite.sprite_frames.has_animation("attack"):
		attack_sprite.play("attack")
	else:
		attacking = false
		return  

	await get_tree().create_timer(2.0).timeout  
	attack_sprite.visible = false  
	attacking = false  

func _on_AttackArea_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(attack_damage)
