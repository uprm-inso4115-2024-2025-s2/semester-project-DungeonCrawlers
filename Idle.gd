extends State
class_name Idle
@export var enemy: CharacterBody2D
var move_direction: Vector2
var timer: float

func Enter():
	move_direction = Vector2.ZERO
	timer = randf_range(1,3)

func Update(delta: float):
	if timer > 0:
		timer -= delta
	print(timer)
func Physics_update(delta: float):
	if enemy:
		enemy.velocity = move_direction
	if timer <= 0.0:
		Transitioned.emit(self,"wander")
