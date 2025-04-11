extends Control

var GameOver = false
func SetGameOver(x)->void:
	GameOver = x
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()  # Hide the pause menu when the game starts

# Detect when ESC is pressed
func _input(event: InputEvent) -> void:
	if GameOver:
		return
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()
	elif event.is_action_pressed("how_to_play") and visible: 
		toggle_pause()
func toggle_pause() -> void:
	if visible:
		hide()
		get_tree().paused = false  # Resume game
	else:
		#print("📌 Showing Pause Menu")  # Debugging
		show()
		get_tree().paused = true   # Pause game

# Function for Resume Button
func _on_ResumeButton_pressed() -> void:
	toggle_pause()

func _on_settings_pressed():
	var settings_menu = get_node_or_null("/root/World/MenusCanvas/SettingsMenu")

	if settings_menu:
		settings_menu.open_settings(self)  # ✅ Pass Pause Menu reference
		self.visible = false  # Hide the Pause Menu
		#DEBUG
		#print("✅ Settings opened from Pause Menu")
	#else:
		#print("❌ ERROR: Settings Menu not found!")

func _on_exit_pressed() -> void:
	#print("Returning to Main Menu...")  # Debugging
	get_tree().paused = false  # Ensure the game is unpaused
	get_tree().change_scene_to_file("res://main_menu.tscn")  # Reload Main Menu scene
