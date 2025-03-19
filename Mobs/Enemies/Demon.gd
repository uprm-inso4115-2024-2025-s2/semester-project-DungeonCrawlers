extends CharacterBody2D

@onready var foreground_bar = $AnimatedSprite2D/ForegroundBar

var Demon_health = 100
var Demon_attack = 25
var max_health = 100

func get_Demon_health() -> int:
	return Demon_health

func set_Demon_health(Damage_to_take_away) -> void:
	Demon_health = max(0, Demon_health - Damage_to_take_away)
	update_health(Demon_health)  # Asegurar que la barra de salud se actualiza correctamente
	if Demon_health == 0:
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
	var health_percent = (float(max_health - new_health) * 0.20)
	foreground_bar.size.x = (foreground_bar.size.x - health_percent)
	max_health = new_health
	if max_health > (100 * 0.6):
		foreground_bar.color = Color(0, 255, 0)  # Green
	elif max_health > (100 * 0.3):
		foreground_bar.color = Color(255, 255, 0)  # Yellow
	else:
		foreground_bar.color = Color(255, 0, 0)  # Red
