extends Node2D

@onready var animation = $Traps_sprites/Traps_animations


var trap_pos : Vector2
var trap_damage = 10
var active = false; 

func _ready():
	trap_pos = global_position
	pass # Replace with function body.



func _on_body_entered(body):
	animation.play("trap_motion")
	active = true
	await get_tree().create_timer(1.0).timeout
	
	if (active):
		if body.name == "Player":
			body.set_player_health(trap_damage)
	pass # Replace with function body.


func _on_body_exited(body):
	active = false
	animation.play_backwards("trap_motion")
	pass # Replace with function body.
