extends Control

@onready var return_button = $VBoxContainer/Return

func _ready():
	return_button.pressed.connect(_on_return_pressed)

func _on_return_pressed():
	print("Returning to Settings Menu")
	var settings_menu = preload("res://settings_menu.tscn").instantiate()
	get_tree().current_scene.add_child(settings_menu)
	queue_free()  # Closes the current menu
