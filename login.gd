extends Control

@export var login_state_label: Label
@export var data_label: Label

@export var key_edit_1: TextEdit
@export var key_edit_2: TextEdit
@export var data_edit_1: TextEdit
@export var data_edit_2: TextEdit
# Called when the node enters the scene tree for the first time.
func _ready():
	
	SilentWolf.Auth.sw_session_check_complete.connect(_on_login_complete)
	SilentWolf.Auth.sw_login_complete.connect(_on_login_complete)
	SilentWolf.Auth.sw_logout_complete.connect(_on_logout_complete)
	
	SilentWolf.Auth.auto_login_player()

func _on_register_button_pressed():
	get_tree().change_scene_to_file("res://addons/silent_wolf/Auth/Register.tscn")

func _on_login_button_pressed():
	get_tree().change_scene_to_file("res://addons/silent_wolf/Auth/Login.tscn")

func _on_logout_button_pressed():
	SilentWolf.Auth.logout_player()
	
func _on_logout_complete(a, b):
	update_login_state_label()
		
func _on_login_complete(sw_result):
	update_login_state_label()
		
func update_login_state_label():
	if SilentWolf.Auth.logged_in_player:
		login_state_label.text = "Logged in"
	else:
		login_state_label.text = "Not logged in"

func _on_load_button_pressed():
	load_data()
			
func load_data():
	if SilentWolf.Auth.logged_in_player:
		data_label.text = "Loading"
		
		# load data async
		var sw_result = await SilentWolf.Players.get_player_data(SilentWolf.Auth.logged_in_player).sw_get_player_data_complete
		print("Player data: " + str(sw_result.player_data))
		
		# show load result on data_label
		if sw_result and sw_result.success and sw_result.player_data:
			data_label.text = str(sw_result.player_data)
		else:
			data_label.text = "Load failed"

func _on_save_button_pressed():
	var player_data: Dictionary = {}
	if key_edit_1.text != "":
		player_data[key_edit_1.text] = data_edit_1.text
		
	if key_edit_2.text != "":
		player_data[key_edit_2.text] = data_edit_2.text
		
	save_data(player_data)
		
func save_data(player_data: Dictionary):
	if SilentWolf.Auth.logged_in_player:
		data_label.text = "Saving"
		var sw_result = await SilentWolf.Players.save_player_data(SilentWolf.Auth.logged_in_player, player_data).sw_save_player_data_complete
		data_label.text = "Save success" if sw_result and sw_result.success else "Save failed"
