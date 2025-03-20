extends CharacterBody2D

var health = 100
var attack_damage = 25

func get_Demon_health() -> int:
	return health
	
func set_Demon_health(damage: int) -> void:
	health = max(0, health - damage)
	print("Demon took damage! New health:", health)

func get_Demon_attack() -> int:
	return attack_damage
