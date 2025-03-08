extends Area2D
@onready var animation = $chest_sprite/AnimationPlayer #import animation
var open = false; 
var inside = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _input(event):
	if event.is_action_pressed("interact"):
		if (inside == true) && (open == false):
			animation.play("chest_open")
			open = true
			#here is where the chest opens,connect to other code here

func _on_body_entered(body):
	if body.name == "Player":
		inside = true

func _on_body_exited(body):
	if body.name == "Player":
		inside = false
