extends Control

# Called when the node enters the scene tree for the first time
func _ready():
	$VBoxContainer/StartButton.connect("pressed", Callable(self, "_on_start_pressed"))
	$VBoxContainer/QuitButton.connect("pressed", Callable(self, "_on_quit_pressed"))
	$VBoxContainer/LeaderboardButton.connect("pressed", Callable(self, "_on_leaderboard_pressed"))
	$VBoxContainer/OptionsButton.connect("pressed", Callable(self, "_on_options_pressed"))

func _on_start_pressed():
	get_tree().change_scene_to_file("res://world.tscn") # Change this to your main game scene

func _on_quit_pressed():
	get_tree().quit()

func _on_leaderboard_pressed():
	pass # Implement leaderboard functionality later

func _on_options_pressed():
	pass # Implement options functionality later
