extends Control

@onready var back_button = $VBoxContainer/BackButton  # Correct path

func _ready():
	if back_button:
		back_button.pressed.connect(_on_back_pressed)
	else:
		print("Error: BackButton not found!")

func _on_back_pressed():
	queue_free()  # Removes this settings UI to return to the main settings menu
