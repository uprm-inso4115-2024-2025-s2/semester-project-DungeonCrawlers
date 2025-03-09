extends Control

@onready var return_button = $VBoxContainer/Return

func _ready():
	return_button.pressed.connect(_on_return_pressed)
	center_ui()

func center_ui():
	self.anchor_left = 0
	self.anchor_right = 1
	self.anchor_top = 0
	self.anchor_bottom = 1
	self.set_anchor(SIDE_LEFT, 0,false,true)
	self.set_anchor(SIDE_RIGHT, 1,false,true)
	self.set_anchor(SIDE_TOP, 0,false,true)
	self.set_anchor(SIDE_BOTTOM, 1,false,true)

func _on_return_pressed():
	print("Returning to Settings Menu")
	var settings_menu = preload("res://settings_menu.tscn").instantiate()
	get_tree().current_scene.add_child(settings_menu)
	queue_free()
