extends CharacterBody2D

@export var speed = 50
@export var attack_offset = 0
var player_health = 100
var player_attack = 25

@onready var target = position
# @onready var attack_sprite = $AttackSprite
# @onready var attack_area = $AttackSprite/AttackArea

var attacking = false
var is_moving = false
var last_direction = Vector2.RIGHT

func _input(event):
	if event.is_action_pressed("attack") and not attacking:
		start_attack()
		
func _physics_process(delta):
	velocity = Vector2.ZERO  # Reset velocity every frame
	$PlayerRun.hide()
	#Reset idle
	$PlayerIdle.show()
	$PlayerIdle.play()
	# Handle movement input and adjust position
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		velocity.x = speed
		$PlayerIdle.stop()
		$PlayerIdle.hide()
		$PlayerRun.show()
		$PlayerRun.scale.x = 1
		$PlayerIdle.scale.x = 1
		$Weapon.scale.x = 0.5
		$Weapon.position.x = 9
		$PlayerRun.play()
	
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		velocity.y -= speed 
		$PlayerIdle.stop()
		$PlayerIdle.hide()
		$PlayerRun.show()
		$PlayerRun.play()
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		velocity.y += speed 
		$PlayerIdle.stop()
		$PlayerIdle.hide()
		$PlayerRun.show()
		$PlayerRun.play()
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		velocity.x -= speed 
		$PlayerIdle.stop()
		$PlayerIdle.hide()
		$PlayerRun.show()
		$PlayerRun.scale.x = -1
		$PlayerIdle.scale.x = -1
		$Weapon.scale.x = -0.5
		$Weapon.position.x = -11
		$PlayerRun.play()
	move_and_slide()

func start_attack():

	attacking = true
	$Weapon/AttackAnimation.visible = true

	$Weapon/AttackAnimation.scale = Vector2(1, 1)


	$Weapon/AttackAnimation.position = last_direction * attack_offset


	if abs(last_direction.x) > abs(last_direction.y):
		$Weapon/AttackAnimation.rotation_degrees = 30
		await get_tree().create_timer(0.10).timeout
		$Weapon/AttackAnimation.rotation_degrees = 45
		await get_tree().create_timer(0.10).timeout
		$Weapon/AttackAnimation.rotation_degrees = 60
		await get_tree().create_timer(0.10).timeout
		$Weapon/AttackAnimation.rotation_degrees = 75
		await get_tree().create_timer(0.10).timeout
		$Weapon/AttackAnimation.rotation_degrees = 90
		await get_tree().create_timer(0.10).timeout

	$Weapon/AttackAnimation.rotation_degrees = 0
	attacking = false

#func _on_AttackArea_body_entered(body)->void:
	#return

#player's attack and health system
func get_player_health()->int:
	return player_health
func set_player_health(Attack_incoming)->void:
	player_health = max(0, player_health - Attack_incoming)
	$PlayerHealthBar.update_health(player_health)  # Asegurar que la UI se actualiza
	if player_health == 0:
		get_parent().trigger_game_over(false)  # Notificar al world.gd

func get_player_attack() -> int:
	return player_attack
