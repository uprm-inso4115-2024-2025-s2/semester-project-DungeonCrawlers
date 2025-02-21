extends Control

@onready var back_button = $VBoxContainer/BackButton  # Adjust path if needed

func _ready():
	if back_button:
		back_button.pressed.connect(_on_back_pressed)
	else:
		print("Error: BackButton not found!")

func _on_back_pressed():
	print("Returning to main settings menu")
	queue_free()  # Closes the ControlsSettings menu
