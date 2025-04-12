extends Node2D
var room_size: Vector2 = Vector2(44,46)  # Tamaño del room (ancho, alto)
var matrix = []
var attack_distance_player = 50.0
var attack_distance_player2 = 50.0
var attack_distance_enemy = 30.0
@onready var Boss = $Boss
@onready var EnemySpawner = $EnemySpawner
@onready var Player = $Player
@onready var Player2 = $Player2

@onready var canvas_layer = $CanvasLayer
@onready var game_over_screen = preload("res://UI/game_over_screen.tscn")
@onready var pause_menu = get_node_or_null("PauseMenuUI")
@onready var HowToPlayScene = $"HowToPlay/How To Play"
@onready var Room = $"room/room"
@onready var Room2 = $"room/room2"
@onready var Room3 = $"room/room3"
@onready var Room4 = $"room/room4"


var enemy_attack_cooldowns = {}
var player_attack_cooldown = 0.0
var player2_attack_cooldown = 0.0
var game_over = false

func _ready():
	var array_1 = []
	for a in range(room_size.x):
		array_1.append(0)
		
	for a in range(room_size.y):
		matrix.append(array_1)
	
	#y,x
	matrix[0][0] = Room
	Room.setxy(0,0)
	
	matrix[1][0] = Room2
	Room2.setxy(1,0)
	
	matrix[0][1] = Room3
	Room3.setxy(0,1)
	
	matrix[1][1] = Room4
	Room.setxy(1,1)
	
	Boss.connect("boss_died", Callable(self, "_on_boss_died"))
func _on_boss_died():
	Boss = null  # Set Boss to null to prevent further interactions
	print("Boss has died and is no longer valid!")

func _process(delta):
	if game_over:
		return  # Si el juego ya terminó, evitamos más procesamiento

	var current_time = Time.get_ticks_msec() / 1000.0
	if Input.is_action_just_pressed("player1_attack") and current_time - player_attack_cooldown >= 0.5:
		if Boss:
			var Bossdistance = Player.global_position.distance_to(Boss.global_position)
			if Bossdistance <= attack_distance_player:
				Boss.take_damage(Player.get_player_attack())
		for demon in EnemySpawner.spawned_demons:
			var distance = Player.global_position.distance_to(demon.global_position)
			
			if distance <= attack_distance_player:
				demon.set_Demon_health(Player.get_player_attack())
				demon.update_health(demon.get_Demon_health())


		# Set cooldown timestamp
		player_attack_cooldown = current_time
		
	if Input.is_action_just_pressed("player2_attack") and current_time - player2_attack_cooldown >= 0.5:
		if Boss:
			var Bossdistance = Player2.global_position.distance_to(Boss.global_position)
			if Bossdistance <= attack_distance_player2:
				Boss.take_damage(Player2.get_player_attack())
		for demon in EnemySpawner.spawned_demons:
			var distance = Player2.global_position.distance_to(demon.global_position)
			
			if distance <= attack_distance_player2:
				demon.set_Demon_health(Player2.get_player_attack())
				demon.update_health(demon.get_Demon_health())


		# Set cooldown timestamp
		player2_attack_cooldown = current_time


	for demon in EnemySpawner.spawned_demons:
		if demon not in enemy_attack_cooldowns or current_time - enemy_attack_cooldowns[demon] >= 1.0:

			# Attack Player 1 if in range
			if Player.global_position.distance_to(demon.global_position) <= attack_distance_enemy:
				Player.set_player_health(demon.get_Demon_attack())
				$Player/PlayerHealthBar.update_health(Player.get_player_health())
				enemy_attack_cooldowns[demon] = current_time

			# Attack Player 2 if in range
			if Player2.global_position.distance_to(demon.global_position) <= attack_distance_enemy:
				Player2.set_player_health(demon.get_Demon_attack())
				$Player2/PlayerHealthBar.update_health(Player2.get_player_health())
				enemy_attack_cooldowns[demon] = current_time


	#if Input.is_action_just_pressed("ui_m"):
		#canvas_layer.visible = !canvas_layer.visible
	#$Player/PlayerHealthBar.update_health(Player.get_player_health())

	# Verificar si el jugador ha perdido
	if Player.get_player_health() <= 0:
		trigger_game_over(false)
		return

	# Verificar si el jugador ha ganado (si no quedan enemigos)
	if EnemySpawner.spawned_demons.size() == 0:
		await get_tree().create_timer(0.5).timeout  # Evita falsa detección
		if EnemySpawner.spawned_demons.size() == 0:
			trigger_game_over(true)

func trigger_game_over(victory: bool):
	game_over = true
	get_tree().paused = true  # Pausar el juego
	print("Before adding game_over_screen:", canvas_layer.get_children())

	var screen_instance = game_over_screen.instantiate()
	$GameOver.add_child(screen_instance)
	
	print("After adding game_over_screen:", canvas_layer.get_children())
	screen_instance.process_mode = Node.PROCESS_MODE_ALWAYS

	# Asegurar que el mensaje siempre se centre correctamente
	screen_instance.set_anchors_preset(Control.PRESET_CENTER)
	screen_instance.position = Vector2(0, 0)

	if victory:
		screen_instance.set_message("¡Victoria!")
		print("¡Victoria! Has derrotado a todos los enemigos.")
	else:
		screen_instance.set_message("Game Over")
		print("Game Over. Has sido derrotado.")




func _input(event):
	return
