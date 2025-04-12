extends Area2D

@export var weapon_name: String = "weapon_axe"  # ← asegúrate de que tenga un nombre válido al instanciarse
@export var weapon_scene: PackedScene
func _ready():
	# Para que el arma tenga su sprite correcto al inicio
	var sprite = get_node_or_null("Sprite2D")
	if sprite and sprite is Sprite2D:
		var texture = load("res://Sprites/%s.png" % weapon_name)
		if texture:
			sprite.texture = texture


func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Player entró al área del arma")
		body.nearby_weapon = self
		modulate = Color(0.5, 1, 0.5)

func _on_body_exited(body):
	if body.is_in_group("player"):
		print("Player salió del área del arma")
		if body.nearby_weapon == self:
			body.nearby_weapon = null
		modulate = Color(1, 1, 1)
