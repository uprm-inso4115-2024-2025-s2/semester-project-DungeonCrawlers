extends CharacterBody2D

@onready var foreground_bar = $AnimatedSprite2D/ForegroundBar
@onready var animated_sprite = $AnimatedSprite2D
@export var speed: float = 50  # Movement Speed
@export var heal_amount: int = 10  # How much to heal
@export var min_heal_time: float = 3.0  # Min interval between heals
@export var max_heal_time: float = 6.0  # Max interval between heals

var player = null
var move_direction = Vector2.ZERO
var heal_timer = null  # Timer for healing

func _ready():
	animated_sprite.play("idle")
	player = get_tree().get_first_node_in_group("player")
	if not player:
		push_error("Player node not found!")

	# Set up heal timer
	heal_timer = Timer.new()
	heal_timer.wait_time = randf_range(min_heal_time, max_heal_time)
	heal_timer.autostart = true
	heal_timer.one_shot = false
	heal_timer.timeout.connect(_on_heal_timer_timeout)
	add_child(heal_timer)

func _physics_process(delta):
	if player:
		var distance_to_player = player.global_position.distance_to(global_position)

		if distance_to_player < 35:
			move_direction = Vector2.ZERO
			if animated_sprite.animation != "idle":
				animated_sprite.play("idle")
		else:
			move_direction = (player.global_position - global_position).normalized()
			if animated_sprite.animation != "run":
				animated_sprite.play("run")

		velocity = move_direction * speed
		move_and_collide(velocity * delta)

		# Flip animation
		if move_direction.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true
		elif move_direction.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false

func _on_heal_timer_timeout():
	if player and player.global_position.distance_to(global_position) < 35:
		# Heal the player (assuming player has a "heal" method)
		player.set_health(heal_amount)
		
		print("Ally healed the player for ", heal_amount, " HP!")

	# Reset timer with a new random interval
	heal_timer.wait_time = randf_range(min_heal_time, max_heal_time)
	heal_timer.start()
