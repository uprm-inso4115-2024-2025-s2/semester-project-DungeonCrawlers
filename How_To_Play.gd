#How_To_Play.gd
extends Control

func _ready() -> void:
	hide()  # Hide the pause menu when the game starts

# Detect when ESC is pressed
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		#print("ESC Pressed")  # Debug print
		get_tree().paused = false
	elif event.is_action_pressed("how_to_play"):  
		# H
		print("ESC Pressed")  # Debug print
		get_tree().paused = false
		get_tree().change_scene_to_file("res://world.tscn")

func toggle_htp_pause() -> void:
	if visible:
		hide()
		get_tree().paused = false  # Resume game
	else:
		#print("📌 Showing Pause Menu")  # Debugging
		show()
		move_to_front()  # Ensure Pause Menu is the top UI element
		modulate.a = 1  # Ensure it is fully visible
		# get_tree().paused = true   # Pause game
