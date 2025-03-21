extends CharacterBody2D

enum State { IDLE, CHASE, DEAD }

@export var speed: float = 10.0
@export var player_detection_range: float = 700.0
@export var health: int = 100  # Add health for death state

var current_state = State.IDLE
var player: CharacterBody2D = null

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _process(delta):
	match current_state:
		State.IDLE:
			play_animation("idle")
			if player and global_position.distance_to(player.global_position) < player_detection_range:
				change_state(State.CHASE)

		State.CHASE:
			play_animation("run")
			move_towards_player()
			if should_attack():
				throw_sword()
			if should_summon():
				summon_mobs()
			
		State.DEAD:
			play_animation("death")
			

func change_state(new_state):
	if current_state != new_state:
		current_state = new_state

func move_towards_player():
	if player:
		velocity = (player.global_position - global_position).normalized() * speed
		move_and_slide()

func play_animation(anim_name):
	if $AnimationPlayer.current_animation != anim_name:
		$AnimationPlayer.play(anim_name)
		

func take_damage(amount):
	health -= amount
	if health <= 0:
		change_state(State.DEAD)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		queue_free()

func throw_sword():
	var sword = preload("res://sword_projectile.tscn").instantiate()
	sword.global_position = global_position
	sword.set_direction(player.global_position)
	get_parent().add_child(sword)
	await get_tree().create_timer(10.0).timeout  # Cooldown before next throw
func should_attack():
	return global_position.distance_to(player.global_position) < 100 and randf() < 0.02

func should_summon():
	return randf() < 0.01

func summon_mobs():
	for i in range(1):
		var mob = preload("res://Mobs/Enemies/enemy_2D.tscn").instantiate()
		mob.global_position = global_position + Vector2(randf_range(-30, 30), randf_range(-30, 30))
		get_parent().add_child(mob)
		await get_tree().create_timer(1000000000000.0).timeout  # Cooldown
