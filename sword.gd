extends "res://Weapons/weapon.gd"

func _ready():
	weapon_name = "sword"

func start_attack():
	if has_node("AttackAnimation"):
		$AttackAnimation.play("attack")
		print("⚔️ Ataque con espada!")
	else:
		print("⚠️ No se encontró AttackAnimation")
