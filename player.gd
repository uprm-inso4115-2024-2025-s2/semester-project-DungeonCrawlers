extends CharacterBody2D

@export var speed = 50
@export var attack_offset = 0
var player_health = 100
var player_attack = 25

var movement_input = Vector2.ZERO
var attacking = false
var is_moving = false
var last_direction = Vector2.RIGHT

@onready var target = position

func _ready():
    if multiplayer.is_server():
        set_process(false)  # Server does not process local movement

func _input(event):
    if event.is_action_pressed("attack") and not attacking:
        start_attack()

func _process(delta):
    if multiplayer.is_server():
        return  # Server does not handle client input directly

    handle_movement_input()  # Capture movement input
    if movement_input != Vector2.ZERO:
        rpc_id(1, "send_movement_input", movement_input)  # Send movement to server

func _physics_process(delta):
    velocity = movement_input * speed  # Apply movement velocity
    move_and_slide()  # Move the character using physics engine

    update_animation_state()  # Ensure animations work correctly

func handle_movement_input():
    movement_input = Vector2.ZERO  # Reset input

    if Input.is_action_pressed("ui_right"):
        movement_input.x += 1
    if Input.is_action_pressed("ui_left"):
        movement_input.x -= 1
    if Input.is_action_pressed("ui_down"):
        movement_input.y += 1
    if Input.is_action_pressed("ui_up"):
        movement_input.y -= 1

    movement_input = movement_input.normalized()  # Prevent diagonal speed boost

func update_animation_state():
    if movement_input != Vector2.ZERO:
        is_moving = true
        $PlayerIdle.stop()
        $PlayerIdle.hide()
        $PlayerRun.show()
        $PlayerRun.play()

        if movement_input.x > 0:
            $PlayerRun.scale.x = 1
            $PlayerIdle.scale.x = 1
            $Weapon.scale.x = 0.5
            $Weapon.position.x = 9
        elif movement_input.x < 0:
            $PlayerRun.scale.x = -1
            $PlayerIdle.scale.x = -1
            $Weapon.scale.x = -0.5
            $Weapon.position.x = -11
    else:
        is_moving = false
        $PlayerRun.hide()
        $PlayerIdle.show()
        $PlayerIdle.play()

@rpc("reliable", "call_local")
func send_movement_input(direction: Vector2):
    pass  # Processed by the server

@rpc("unreliable", "call_local")
func update_player_position(new_position: Vector2):
    if multiplayer.get_unique_id() != 1:  # If not the server
        global_position = new_position  # Apply position updates
