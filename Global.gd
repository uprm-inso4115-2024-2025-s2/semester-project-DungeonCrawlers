extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Loading in SilentWolf

	SilentWolf.configure({
		"api_key": "d9pw7sgeBu7msbQh4vAqxgxSDQVKKqGaoTKGIj81",
		"game_id": "DungeonCrawlers",
		"log_level": 1
	})

	SilentWolf.configure_auth({
		"redirect_to_scene": "res://Main.tscn",
		"login_scene": "res://addons/silent_wolf/Auth/Login.tscn",
		"email_confirmation_scene": "res://addons/silent_wolf/Auth/ConfirmEmail.tscn",
		"reset_password_scene": "res://addons/silent_wolf/Auth/ResetPassword.tscn",
		"session_duration_seconds": 0,
		"saved_session_expiration_days": 30
	})
