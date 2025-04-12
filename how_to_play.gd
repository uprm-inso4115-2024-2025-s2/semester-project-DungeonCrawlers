#How_To_Play.gd
extends Control

var GameOver = false
func SetGameOver(x)->void:
	GameOver = x


func _ready() -> void:
	hide()  # Hide the pause menu when the game starts

# Detect when ESC is pressed
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("how_to_play"):  
		toggle_htp_pause()
	elif event.is_action_pressed("ui_cancel") and visible:
		toggle_htp_pause()
func toggle_htp_pause() -> void:
	if GameOver:
		return
	if visible:
		hide()
		get_tree().paused = false  # Resume game
	else:
		show()
		get_tree().paused = true
