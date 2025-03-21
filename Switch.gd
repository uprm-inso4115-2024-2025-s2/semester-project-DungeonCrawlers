extends Area2D

@onready var sprite_on: Sprite2D = $switch_on_sprite  # Reference to the "on" state sprite
@onready var sprite_off: Sprite2D = $switch_off_sprite  # Reference to the "off" state sprite
@onready var door: Area2D = get_node("%door")

var is_on = false  # Tracks whether the switch is on or off
var player_near = false  # Tracks if the player is near the switch
var door_in_range = false # Tracks if there is a door near the switch

func _ready():
	sprite_on.visible = false
	pass

func _input(event):
	if player_near and event.is_action_pressed("interact"):
		toggle_switch()

func toggle_switch():
	is_on = !is_on
	update_switch_state()
	if door_in_range:
		door.toggle_door(is_on)

func update_switch_state():
	# Toggle the visibility of the sprites based on the switch's state
	sprite_on.visible = is_on
	sprite_off.visible = not is_on

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_near = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_near = false

func _on_area_entered(area: Area2D) -> void:
	if area == door:
		door_in_range = true
