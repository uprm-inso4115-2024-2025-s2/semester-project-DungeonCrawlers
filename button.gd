extends Area2D

@onready var sprite_on: Sprite2D = $button_on_sprite  # Reference to the "on" state sprite
@onready var sprite_off: Sprite2D = $button_off_sprite  # Reference to the "off" state sprite

var is_on = false  # Tracks whether the switch is on or off
var player_near = false  # Tracks if the player is near the switch

func _ready():
	pass

func _input(event):
	if player_near and event.is_action_pressed("interact"):
		toggle_switch()

func toggle_switch():
	sprite_on.visible = true
	sprite_off.visible = false
	await get_tree().create_timer(0.75).timeout
	sprite_on.visible = false
	sprite_off.visible = true

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_near = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_near = false
