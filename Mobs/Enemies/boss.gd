extends CharacterBody2D

enum State { IDLE, CHASE, DEAD }
@onready var has_summoned: bool
@onready var foreground_bar = $AnimatedSprite2D/Foreground_bar
@export var max_health = 100
@export var speed: float = 10.0
@export var player_detection_range: float = 700.0
@export var health: int = 100 

var summons_list = [] 
signal boss_died
var current_state = State.IDLE
#var player: CharacterBody2D = null
var players := []

#func _ready():
	#player = get_tree().get_first_node_in_group("player")
func _ready():
	players = get_tree().get_nodes_in_group("player")


#func _process(delta):
	#match current_state:
		#State.IDLE:
			#play_animation("idle")
			#if player and global_position.distance_to(player.global_position) < player_detection_range:
				#change_state(State.CHASE)

func _process(delta):
	players = get_tree().get_nodes_in_group("player")
	#print("Boss sees closest:", get_closest_player().name)
	match current_state:
		State.IDLE:
			play_animation("idle")
			
			var closest = get_closest_player()
			if closest and global_position.distance_to(closest.global_position) < player_detection_range:
				change_state(State.CHASE)


		State.CHASE:
			play_animation("run")
			move_towards_player()
			if should_attack():
				throw_sword()
			
			
		State.DEAD:
			play_animation("death")
		

func change_state(new_state):
	if current_state != new_state:
		current_state = new_state

func get_closest_player():
	var closest = null
	var min_dist = INF
	for p in players:
		if not is_instance_valid(p):
			continue
		var dist = global_position.distance_to(p.global_position)
		if dist < min_dist:
			min_dist = dist
			closest = p
	return closest


#func move_towards_player():
	#if player:
		#velocity = (player.global_position - global_position).normalized() * speed
		#move_and_slide()

func move_towards_player():
	var closest = get_closest_player()
	if closest:
		velocity = (closest.global_position - global_position).normalized() * speed
		move_and_slide()


func play_animation(anim_name):
	if $AnimationPlayer.current_animation != anim_name:
		$AnimationPlayer.play(anim_name)
		

func take_damage(amount):
	health -= amount
	update_health_bar(health)
	if health <= 50:
		summon_mobs()
	if health <= 0:
		change_state(State.DEAD)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		emit_signal("boss_died")
		queue_free()
		cleanup_summons()

#func throw_sword():
	#var sword = preload("res://sword_projectile.tscn").instantiate()
	#sword.global_position = global_position
	#sword.set_direction(player.global_position)
	#get_parent().add_child(sword)
	#await get_tree().create_timer(10.0).timeout
	
func throw_sword():
	var closest = get_closest_player()
	if closest:
		var sword = preload("res://sword_projectile.tscn").instantiate()
		sword.global_position = global_position
		sword.set_direction(closest.global_position)
		get_parent().add_child(sword)
		await get_tree().create_timer(10.0).timeout

	
#func should_attack():
	#return global_position.distance_to(player.global_position) < 100 and randf() < 0.002

func should_attack():
	var closest = get_closest_player()
	return closest and global_position.distance_to(closest.global_position) < 100 and randf() < 0.002


func should_summon():
	return true

func summon_mobs():
	if has_summoned:
		return
	health = 100
	update_health_bar(health)
	for i in range(2):
		has_summoned = true
		var mob = preload("res://Mobs/Enemies/enemy_2D.tscn").instantiate()
		mob.global_position = global_position + Vector2(randf_range(-30, 30), randf_range(-30, 30))
		get_parent().add_child(mob)
		summons_list.append(mob)
		await get_tree().create_timer(1.0).timeout
func cleanup_summons():
	for mob in summons_list:
		mob.queue_free()  # Remove the mob from the scene
	summons_list.clear()
	
func update_health_bar(new_health):
	var health_percent = (float(max_health - new_health)*.20)
	foreground_bar.size.x = (foreground_bar.size.x - health_percent)
	max_health = new_health
