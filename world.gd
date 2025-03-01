extends Node2D

var attack_distance_player = 50.0
var attack_distance_enemy = 30.0
@onready var EnemySpawner = $EnemySpawner
@onready var Player = $Player
@onready var canvas_layer = $CanvasLayer 

var enemy_attack_cooldowns = {}
var player_attack_cooldown= 0.0
func _process(delta):
	var current_time = Time.get_ticks_msec() / 1000.0
	if Input.is_action_just_pressed("attack") and current_time - player_attack_cooldown >= 0.5:
		for demon in EnemySpawner.spawned_demons:
			var distance = Player.global_position.distance_to(demon.global_position)
			
			if distance <= attack_distance_player:
				print(demon.get_Demon_health())
				demon.set_Demon_health(Player.get_player_attack())
				print(demon.get_Demon_health())

		# Set cooldown timestamp
		player_attack_cooldown = current_time  
	
	var nearest_demon = null
	var min_distance = attack_distance_enemy
	for demon in EnemySpawner.spawned_demons:
		var distance = Player.global_position.distance_to(demon.global_position)

		if distance <= attack_distance_enemy and distance < min_distance:
			min_distance = distance
			nearest_demon = demon
	
	if nearest_demon:
		if nearest_demon not in enemy_attack_cooldowns or current_time - enemy_attack_cooldowns[nearest_demon] >= 1.0:
			# Only the nearest demon attacks
			print(Player.get_player_health())
			Player.set_player_health(nearest_demon.get_Demon_attack())
			print(Player.get_player_health())

			# Update the cooldown timer for this demon
			enemy_attack_cooldowns[nearest_demon] = current_time
	if Input.is_action_just_pressed("ui_m"):
		canvas_layer.visible = !canvas_layer.visible
