extends CharacterBody2D
@onready var foreground_bar = $AnimatedSprite2D/ForegroundBar
@onready var animated_sprite = $AnimatedSprite2D
@export var speed: float = 25  # Adjustable enemy speed

var potion_packed: PackedScene = preload("res://Potions/strength_potion.tscn")
var Demon_health = 100
var Demon_attack = 25
var max_health = 100
var player = null
var move_direction = Vector2.ZERO

func get_Demon_health() -> int:
	return Demon_health
	
func set_Demon_health(Damage_to_take_away) ->void:
	Demon_health = max(0, Demon_health - Damage_to_take_away)
	update_health(Demon_health)  # Asegurar que la barra de salud se actualiza correctamente
	if Demon_health == 0:
		spawn_strength_potion()
		if get_parent().EnemySpawner.spawned_demons.has(self):
			get_parent().EnemySpawner.spawned_demons.erase(self)  # Remover de la lista de enemigos
			queue_free()  # Eliminar enemigo de la escena
			# Solo verificar victoria si el enemigo realmente fue eliminado
			if get_parent().EnemySpawner.spawned_demons.size() == 0:
				get_parent().trigger_game_over(true)  # Notificar victoria

func get_Demon_attack() -> int:
	return Demon_attack

func update_health(new_health):
	# Animate health bar width
	var health_percent = (float(max_health - new_health)*.20)
	foreground_bar.size.x = (foreground_bar.size.x - health_percent)
	max_health = new_health
	if max_health > (100*0.6):
		foreground_bar.color = Color(0, 255, 0)  # Green
	elif max_health > (100*0.3):
		foreground_bar.color = Color(255, 255, 0)  # Yellow
	else:
		foreground_bar.color = Color(255, 0, 0)  # Red
	# Change color based on health

func _ready():
	animated_sprite.play("Idle")
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta):
	if player:
		move_direction = (player.global_position - global_position).normalized()
		animated_sprite.play("Run")
	else:
		if randf() < 0.01:
			move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
			
		if randf() < 0.02:
			move_direction = Vector2.ZERO
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	velocity = move_direction * speed
	move_and_collide(delta * velocity)
	
	if move_direction.x < 0:
		animated_sprite.flip_h = true
	elif move_direction.x > 0:
		animated_sprite.flip_h = false
		

func spawn_strength_potion() -> void:
	print("💥 Spawning potion now")
	# If you want it 100 % current every time, use load():
	var potion_packed: PackedScene = load("res://Potions/strength_potion.tscn")
	var potion := potion_packed.instantiate()
	assert(potion.get_script() != null, "Potion spawned without script!")
	get_parent().add_child(potion)
	potion.global_position = global_position
	queue_free()
