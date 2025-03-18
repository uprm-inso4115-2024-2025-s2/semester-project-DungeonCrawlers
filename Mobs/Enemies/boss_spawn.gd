extends Node2D

@onready var main = get_tree().current_scene

var count = 0
var boss_scene := preload("res://Mobs/Enemies/boss.tscn")
var spawn_points := []
var spawned_boss := []  # List to store demons
var HealthBars := []
# Called when the node enters the scene tree for the first time.

func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)
			


func _on_timer_timeout() -> void:
	var spawn = spawn_points[randi() % spawn_points.size()]
	var boss = boss_scene.instantiate()
	boss.position = spawn.position
	main.add_child(boss)
	spawned_boss.append(boss)
	count +=1
	if count>=1:
		$Timer.stop()
