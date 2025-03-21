extends Control

# Called when the node enters the scene tree for the first time
func _ready():
	var start_stylebox = StyleBoxTexture.new()
	start_stylebox.texture = load("res://main_menu_assets/Start.png")  
	$VBoxContainer/Start.add_theme_stylebox_override("normal", start_stylebox)

	var start_hover_stylebox = StyleBoxTexture.new()
	start_hover_stylebox.texture = load("res://main_menu_assets/Start_pressed.png")  
	$VBoxContainer/Start.add_theme_stylebox_override("hover", start_hover_stylebox)

	var lead_stylebox = StyleBoxTexture.new()
	lead_stylebox.texture = load("res://main_menu_assets/Leaderboard.png")  
	$VBoxContainer/Leaderboard.add_theme_stylebox_override("normal", lead_stylebox)

	var lead_hover_stylebox = StyleBoxTexture.new()
	lead_hover_stylebox.texture = load("res://main_menu_assets/Leaderboard_pressed.png")  
	$VBoxContainer/Leaderboard.add_theme_stylebox_override("hover", lead_hover_stylebox)

	var options_stylebox = StyleBoxTexture.new()
	options_stylebox.texture = load("res://main_menu_assets/Options.png")  
	$VBoxContainer/Options.add_theme_stylebox_override("normal", options_stylebox)

	var options_hover_stylebox = StyleBoxTexture.new()
	options_hover_stylebox.texture = load("res://main_menu_assets/Options_pressed.png")  
	$VBoxContainer/Options.add_theme_stylebox_override("hover", options_hover_stylebox)

	var quit_stylebox = StyleBoxTexture.new()
	quit_stylebox.texture = load("res://main_menu_assets/Quit.png")  
	$VBoxContainer/Quit.add_theme_stylebox_override("normal", quit_stylebox)

	var quit_hover_stylebox = StyleBoxTexture.new()
	quit_hover_stylebox.texture = load("res://main_menu_assets/Quit_pressed.png")  
	$VBoxContainer/Quit.add_theme_stylebox_override("hover", quit_hover_stylebox)
	
	var label_background = StyleBoxTexture.new()
	label_background.texture = load("res://main_menu_assets/Foreground.png") 
	$Label.add_theme_stylebox_override("panel", label_background)

	$VBoxContainer/Start.connect("pressed", Callable(self, "_on_start_pressed"))
	$VBoxContainer/Quit.connect("pressed", Callable(self, "_on_quit_pressed"))
	$VBoxContainer/Leaderboard.connect("pressed", Callable(self, "_on_leaderboard_pressed"))
	$VBoxContainer/Options.connect("pressed", Callable(self, "_on_options_pressed"))


func _on_start_pressed():
	get_tree().change_scene_to_file("res://world.tscn") 

func _on_quit_pressed():
	get_tree().quit()

func _on_leaderboard_pressed():
	pass # Implement leaderboard functionality later

func _on_options_pressed():
	get_tree().change_scene_to_file("res://settings_menu.tscn") 
