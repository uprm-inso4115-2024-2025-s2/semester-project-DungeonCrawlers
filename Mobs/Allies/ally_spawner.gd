extends Node2D

@onready var main = get_tree().current_scene


var ally_scene := preload("res://Mobs/Allies/ally_2D.tscn")
var spawn_points := []
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)
			


func _on_timer_timeout() -> void:
	var spawn = spawn_points[randi() % spawn_points.size()]
	var ally = ally_scene.instantiate()
	ally.position = spawn.position
	main.add_child(ally)
