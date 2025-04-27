extends Area2D

@export var buff_duration: float = 10.0

func _ready() -> void:
	print("🍾 Potion ready at ", global_position)
	# detect when the player walks over it
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	print("⚡ body_entered! ", body.name, "  groups=", body.get_groups())
	if body.is_in_group("player") and body.has_method("apply_strength_buff"):
		body.apply_strength_buff(buff_duration)
		queue_free()  # remove the potion
