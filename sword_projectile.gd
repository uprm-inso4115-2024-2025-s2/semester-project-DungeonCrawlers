extends Area2D

@export var speed: float = 200.0
var direction: Vector2

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	position += direction * speed * delta

func set_direction(target_pos):
	direction = (target_pos - global_position).normalized()
	rotation = direction.angle()  

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.set_player_health(10)  
		queue_free() 

	if body.is_in_group("wall"):  
		queue_free()
