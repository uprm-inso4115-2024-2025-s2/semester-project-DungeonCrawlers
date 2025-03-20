extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()  # Hide the pause menu when the game starts

# Detect when ESC is pressed
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		#print("ESC Pressed")  # Debug print
		toggle_pause()


# Function to pause/unpause the game
func toggle_pause() -> void:
	if visible:
		hide()
		get_tree().paused = false  # Resume game
	else:
		show()
		get_tree().paused = true   # Pause game

# Function for Resume Button
func _on_ResumeButton_pressed() -> void:
	toggle_pause()
