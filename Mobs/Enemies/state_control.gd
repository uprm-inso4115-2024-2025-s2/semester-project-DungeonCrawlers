extends Node

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

func _ready():
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	
	
		

func _process(delta):
	if current_state:
		current_state.Update(delta)


func _physics_process(delta):
	if current_state:
		print(current_state)
		current_state.Physics_update(delta)


func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = state.get(new_state_name.to_lower())
	if !new_state:
		return
		
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state
