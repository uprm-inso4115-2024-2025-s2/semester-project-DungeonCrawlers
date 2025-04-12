extends "res://Weapons/weapon.gd"

func _ready():
	weapon_name = "weapon_baton_with_spikes"

func start_attack():
	var anim = get_node("AttackAnimation")
	anim.visible = true
	anim.rotation_degrees = 0
	anim.scale = Vector2(1, 1)
	anim.position = Vector2(16, 4)  # Ajusta según tu arma

	var is_facing_left = get_parent().last_direction.x < 0

	if is_facing_left:
		anim.scale.x = -1
	else:
		anim.scale.x = 1

	# Movimiento estilo swing de bate
	var angles = [0, 20, 40, 60, 75]

	for angle in angles:
		anim.rotation_degrees = -angle if is_facing_left else angle
		await get_tree().create_timer(0.02).timeout

	for angle in angles.inverted():
		anim.rotation_degrees = -angle if is_facing_left else angle
		await get_tree().create_timer(0.015).timeout

	anim.rotation_degrees = 0
	anim.visible = false
	print("🏏 Swing lateral ejecutado")
