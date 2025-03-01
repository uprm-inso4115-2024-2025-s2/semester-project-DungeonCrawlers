extends Node2D

@onready var main = get_tree().current_scene

var count = 0
var demon_scene := preload("res://Mobs/Enemies/enemy_2d.tscn")
var spawn_points := []
var spawned_demons := []  # List to store demons
# Called when the node enters the scene tree for the first time.

func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)
			


func _on_timer_timeout() -> void:
	var spawn = spawn_points[randi() % spawn_points.size()]
	var demon = demon_scene.instantiate()
	demon.position = spawn.position
	main.add_child(demon)
	spawned_demons.append(demon)
	count +=1
	if count>=3:
		$Timer.stop()
