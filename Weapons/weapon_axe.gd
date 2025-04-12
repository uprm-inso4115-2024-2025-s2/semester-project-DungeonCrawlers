extends "res://Weapons/weapon.gd"

func _ready():
	weapon_name = "weapon_axe"

func start_attack():
	if has_node("AttackAnimation"):
		$AttackAnimation.play("attack")
		print("🪓 Ataque con hacha!")
	else:
		print("⚠️ No se encontró AttackAnimation")
