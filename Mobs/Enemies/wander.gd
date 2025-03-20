extends State
class_name Wander

@export var enemy: CharacterBody2D
@export var speed := 10.0
var move_direction: Vector2
var wander_time: float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1),randf_range(-1, 1))
	wander_time = randf_range(1,3)

func Enter():
	
	randomize_wander()

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	
	else:
		randomize_wander()

func Physics_update(delta: float):

	if enemy:
		enemy.velocity = move_direction * speed
