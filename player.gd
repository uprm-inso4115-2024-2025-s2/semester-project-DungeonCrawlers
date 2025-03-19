extends CharacterBody2D

@export var speed = 50
@export var attack_offset = 0
var player_health = 100
var player_attack = 25

var movement_input = Vector2.ZERO
var attacking = false
var is_moving = false
var last_direction = Vector2.RIGHT

# Variables for interpolation
var target_position: Vector2
var interpolation_speed: float = 10.0  # Base interpolation speed

@onready var target = position

func _ready():
	# Initialize target_position with the current position.
	target_position = global_position
	if multiplayer.is_server():
		set_process(false)  # Server doesn't handle local player movement

func _input(event):
	if event.is_action_pressed("attack") and not attacking:
		start_attack()

func _process(delta):
	if multiplayer.is_server():
		return  # Server does not handle local input
	
	handle_movement_input()  # Capture movement input
	if movement_input != Vector2.ZERO:
		rpc_id(1, "send_movement_input", movement_input)  # Send movement input to the server

func _physics_process(delta):
	if is_local_player():
		velocity = movement_input * speed
		move_and_slide()
		# Keep target_position in sync with local movement.
		target_position = global_position
	else:
		# For remote players, smoothly interpolate toward the target position.
		var adjusted_speed = interpolation_speed
		if multiplayer.has_method("get_average_ping"):
			var avg_ping = multiplayer.get_average_ping()
			if avg_ping > 100:
				adjusted_speed *= 1.5  # Increase interpolation speed for high ping
		global_position = global_position.lerp(target_position, adjusted_speed * delta)
	
	update_animation_state()

func handle_movement_input():
	movement_input = Vector2.ZERO  # Reset input
	if Input.is_action_pressed("ui_right"):
		movement_input.x += 1
	if Input.is_action_pressed("ui_left"):
		movement_input.x -= 1
	if Input.is_action_pressed("ui_down"):
		movement_input.y += 1
	if Input.is_action_pressed("ui_up"):
		movement_input.y -= 1
	movement_input = movement_input.normalized()  # Normalize to prevent diagonal speed boost

func update_animation_state():
	if movement_input != Vector2.ZERO:
		is_moving = true
		$PlayerIdle.stop()
		$PlayerIdle.hide()
		$PlayerRun.show()
		$PlayerRun.play()
		if movement_input.x > 0:
			$PlayerRun.scale.x = 1
			$PlayerIdle.scale.x = 1
			$Weapon.scale.x = 0.5
			$Weapon.position.x = 9
		elif movement_input.x < 0:
			$PlayerRun.scale.x = -1
			$PlayerIdle.scale.x = -1
			$Weapon.scale.x = -0.5
			$Weapon.position.x = -11
	else:
		is_moving = false
		$PlayerRun.hide()
		$PlayerIdle.show()
		$PlayerIdle.play()

@rpc("reliable", "call_local")
func send_movement_input(direction: Vector2):
	# This RPC is meant to be processed by the server.
	pass

@rpc("unreliable", "call_local")
func update_player_position(player_id: int, new_position: Vector2):
	# Update target_position for remote players only.
	if player_id != multiplayer.get_unique_id():
		target_position = new_position

func is_local_player() -> bool:
	# Customize this helper based on how you identify the local player.
	# For example, if your node's name is "PlayerX" where X is the unique ID.
	return multiplayer.get_unique_id() == int(name.get_slice("Player", 1))

func start_attack():
	attacking = true
	$Weapon/AttackAnimation.visible = true
	$Weapon/AttackAnimation.scale = Vector2(1, 1)
	$Weapon/AttackAnimation.position = last_direction * attack_offset
	
	# Example attack animation sequence (adjust as needed)
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

# --- Added Functions ---
func get_player_health() -> int:
	# Returns the current player's health value.
	return player_health

func get_player_attack() -> int:
	# Returns the current player's attack value.
	return player_attack
