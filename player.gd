extends CharacterBody2D

@export var speed = 50
@export var attack_offset = 0
var player_health = 100
var player_attack = 25
var current_weapon = null
var nearby_weapon: Node = null

@onready var target = position
var attacking = false
var is_moving = false
var last_direction = Vector2.RIGHT

func _ready():
	equip_default_weapon()

func equip_default_weapon():
	#  Limpiar lo que sea que haya en Weapon (incluso si ya se limpió antes)
	for child in $Weapon.get_children():
		child.queue_free()

	# Luego instanciar el arma por defecto
	var weapon_scene = preload("res://Weapons/weapon_axe.tscn")
	var weapon_instance = weapon_scene.instantiate()
	weapon_instance.weapon_name = "weapon_axe"

	$Weapon.add_child(weapon_instance)
	current_weapon = weapon_instance
	update_weapon_sprite()

func _input(event):
	if event.is_action_pressed("attack") and not attacking:
		start_attack()

func _physics_process(delta):
	velocity = Vector2.ZERO
	$PlayerRun.hide()
	$PlayerIdle.show()
	$PlayerIdle.play()

	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		velocity.x = speed
		$PlayerIdle.stop()
		$PlayerIdle.hide()
		$PlayerRun.show()
		$PlayerRun.scale.x = 1
		$PlayerIdle.scale.x = 1
		$Weapon.scale.x = 0.5
		$Weapon.position.x = 9
		$PlayerRun.play()

	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		velocity.y -= speed
		$PlayerIdle.stop()
		$PlayerIdle.hide()
		$PlayerRun.show()
		$PlayerRun.play()

	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		velocity.y += speed
		$PlayerIdle.stop()
		$PlayerIdle.hide()
		$PlayerRun.show()
		$PlayerRun.play()

	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		velocity.x -= speed
		$PlayerIdle.stop()
		$PlayerIdle.hide()
		$PlayerRun.show()
		$PlayerRun.scale.x = -1
		$PlayerIdle.scale.x = -1
		$Weapon.scale.x = -0.5
		$Weapon.position.x = -11
		$PlayerRun.play()
	move_and_collide(delta * velocity)

func start_attack():
	if current_weapon:
		var anim_node = current_weapon.get_node_or_null("AttackAnimation")
		var sprite_node = current_weapon.get_node_or_null("Sprite2D")

		if anim_node and anim_node is AnimatedSprite2D:
			print(" Animación de ataque con rotación ejecutada.")
			attacking = true

			# Asegura que esté visible
			anim_node.visible = true
			anim_node.scale = Vector2(1, 1)
			anim_node.position = last_direction * attack_offset

			# Oculta el sprite base si existe
			if sprite_node:
				sprite_node.visible = false

			# Reproduce animación (opcional)
			anim_node.play("attack")

			# Rotación estilo ataque
			if abs(last_direction.x) > abs(last_direction.y):
				for angle in [30, 45, 60, 75, 90]:
					anim_node.rotation_degrees = angle
					await get_tree().create_timer(0.05).timeout
			else:
				for angle in [-30, -45, -60, -75, -90]:
					anim_node.rotation_degrees = angle
					await get_tree().create_timer(0.05).timeout

			# Reset
			anim_node.rotation_degrees = 0
			if sprite_node:
				sprite_node.visible = true

			attacking = false

#func _on_AttackArea_body_entered(body)->void:
	#return

#player's attack and health system
func set_health(heal)-> void:
	if (player_health + heal) >= 100:
		player_health = 100 
	else:
		player_health = max(0, player_health + heal)
	$PlayerHealthBar.update_health(player_health)
func get_player_health()->int:
	return player_health

func set_player_health(Attack_incoming) -> void:
	player_health = max(0, player_health - Attack_incoming)

	$PlayerHealthBar.update_health(player_health)  # Asegurar que la UI se actualiza
	if player_health == 0:
		get_parent().trigger_game_over(false)  # Notificar al world.gd


func get_player_attack() -> int:
	return player_attack

func _process(_delta):
	if nearby_weapon:
		print("Hay un arma cerca:", nearby_weapon.weapon_name)
		if Input.is_key_pressed(KEY_E):
			print("Intentando recoger arma...")

			# Soltar arma anterior si existe
			if current_weapon != null:
				if "weapon_name" in current_weapon:
					var dropped_weapon = drop_current_weapon(current_weapon.weapon_name)

					#  Asegura que se coloque justo en la posición del jugador
					if dropped_weapon:
						dropped_weapon.global_position = global_position
						get_parent().add_child(dropped_weapon)
						print(" Arma soltada en posición:", dropped_weapon.global_position)
				else:
					print(" Arma actual no tiene weapon_name")

				# Limpia todas las armas del nodo Weapon
				for child in $Weapon.get_children():
					child.queue_free()

				current_weapon = null

			# Recoger la nueva
			var new_weapon_scene: PackedScene = nearby_weapon.weapon_scene
			if new_weapon_scene:
				var new_weapon_instance = new_weapon_scene.instantiate()
				$Weapon.add_child(new_weapon_instance)
				current_weapon = new_weapon_instance

				if current_weapon.get("weapon_name") != null:
					print("Recogiste:", current_weapon.weapon_name)
				else:
					print("⚠️ El arma recogida no tiene weapon_name")

			nearby_weapon.queue_free()
			nearby_weapon = null

func pick_up_weapon(new_weapon: String):
	current_weapon = new_weapon
	update_weapon_sprite()
	print("Recogiste nueva arma:", new_weapon)

func drop_current_weapon(weapon_name: String) -> Area2D:
	var weapon_scene = preload("res://weapon_pickup.tscn")
	print("weapon_scene cargada:", weapon_scene)

	var weapon_instance = weapon_scene.instantiate() as Area2D
	if weapon_instance == null:
		print("ERROR: No se pudo instanciar el arma")
		return null

	if not "weapon_name" in weapon_instance:
		print("ERROR: El arma no tiene la variable weapon_name")
		return null

	weapon_instance.weapon_name = weapon_name

	# 🧠 Carga la textura visual
	var sprite = weapon_instance.get_node_or_null("Sprite2D")
	if sprite and sprite is Sprite2D:
		sprite.texture = load("res://Sprites/%s.png" % weapon_name)

	# Le damos altura visual
	weapon_instance.z_index = 1

	return weapon_instance

func update_weapon_sprite():
	if current_weapon != null and "weapon_name" in current_weapon:
		var sprite_path = "res://Sprites/%s.png" % current_weapon.weapon_name
		var texture = load(sprite_path)

		if texture:
			var weapon_node = current_weapon.get_node_or_null("Sprite2D")
			if weapon_node and weapon_node is Sprite2D:
				weapon_node.texture = texture
				print("Arma equipada visualmente:", sprite_path)
			else:
				print("No se encontró el nodo Weapon/Sprite2D o no es Sprite2D.")
		else:
			print("No se encontró el sprite para: ", sprite_path)
	else:
		print(" current_weapon es null o no tiene weapon_name")
