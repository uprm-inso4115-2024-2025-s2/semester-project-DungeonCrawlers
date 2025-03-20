#
#extends Control
#
##@onready var ui_layer: CanvasLayer = $CanvasLayer
##@onready var settings: TabContainer = $CanvasLayer/PauseMenu/Settings
##@onready var ui_layer: CanvasLayer = get_node("../CanvasLayer")
##@onready var settings: TabContainer = get_node("../CanvasLayer/PauseMenu/Settings")
##@onready var ui_layer: CanvasLayer = get_node("..")  # Get CanvasLayer (parent)
##@onready var settings: TabContainer = get_node("Panel/Settings")
#
##@onready var ui_layer: CanvasLayer = get_node("..")  # Parent
##@onready var settings: TabContainer = $MenuContainer/Settings
#
#@onready var ui_layer: CanvasLayer = get_node("..")  # Parent
##@onready var settings: TabContainer = get_node("../MenuContainer/Settings")
#@onready var settings: TabContainer = get_node("MenuContainer/Settings")
#
#
#
#
#func _ready():
	#ui_layer.hide()
#
#func _input(event: InputEvent):
	#if event.is_action_pressed("Escape"):
		#if not ui_layer.visible:
			#show_ui_layer()
		#else:
			#resume_game()
#
#func show_ui_layer():
	#pause_game()
	#ui_layer.show()
	#reset_focus()
	#
#func reset_focus():
	#$MenuContainer/Resume.grab_focus()
#
#
##func reset_focus():
	### Updated path for Resume button
	##$CanvasLayer/PauseMenu/Resume.grab_focus()
	#
##func reset_focus():
	### Debug print to see actual nodes under PauseMenu
	##print(get_node("/root/World/CanvasLayer/PauseMenu").get_children())
##
	##var resume_button = get_node("/root/World/CanvasLayer/PauseMenu/Resume")
	##if resume_button:
		##resume_button.grab_focus()
	##else:
		##push_error("Resume button not found! Check the node path.")
#
#
#func pause_game():
	#Engine.time_scale = 0
#
#func resume_game():
	#Engine.time_scale = 1  # Resume game logic
	##settings.hide()        # Hide settings (if open) REACTIVATE
	#ui_layer.hide()        # Hide pause menu
#
#
#func _on_resume_pressed():
	#resume_game()
#
#func _on_option_pressed():
	#settings.show()
	#settings.reset_focus()
#
##func _on_main_menu_pressed():
	##Utilities.switch_scene("MainMenu", self)
	
	
#extends CanvasLayer  # Now the Pause Menu extends CanvasLayer directly
extends Control


@onready var menu_container: VBoxContainer = $MenuContainer
#@onready var settings: TabContainer = $MenuContainer/Settings
@onready var settings: TabContainer = $PauseMenuUI/MenuContainer/Settings


func _ready():
	hide()  # Hide the pause menu at the start

func _input(event: InputEvent):
	if event.is_action_pressed("Escape"):
		if not visible:
			show_ui_layer()
		else:
			resume_game()

func show_ui_layer():
	pause_game()
	show()
	reset_focus()

func reset_focus():
	var resume_button = $MenuContainer/Resume
	if resume_button:
		resume_button.grab_focus()
	else:
		push_error("Resume button not found! Check the node path.")

func pause_game():
	Engine.time_scale = 0

func resume_game():
	Engine.time_scale = 1
	hide()

func _on_resume_pressed():
	resume_game()

func _on_option_pressed():
	settings.show()
	settings.reset_focus()
	#pass #Change later

func _on_main_menu_pressed():
	# Switch to main menu or quit logic
	print("Returning to Main Menu...")
	# get_tree().change_scene_to_file("res://path/to/main_menu.tscn")
