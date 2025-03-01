extends CharacterBody2D

var Demon_health = 100
var Demon_attack = 25

func get_Demon_health() -> int:
	return Demon_health
	
func set_Demon_health(Damage_to_take_away) ->void:
	Demon_health = max(0, Demon_health - Damage_to_take_away)

func get_Demon_attack()-> int:
	return Demon_attack
