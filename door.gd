extends Area2D
@onready var animation = $door_sprite/AnimationPlayer #import animation
@onready var door_collision = %door_collision


var open = false; 
var inside = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _input(event):
	if event.is_action_pressed("interact"):
		if (inside == true) && (open == false):
			animation.play("door_open")
			await get_tree().create_timer(0.75).timeout
			door_collision.set_deferred("disabled", true)
			open = true


func _on_body_entered(body):
	if body.name == "Player":
		inside = true

func _on_body_exited(body):
	if body.name == "Player":
		inside = false
