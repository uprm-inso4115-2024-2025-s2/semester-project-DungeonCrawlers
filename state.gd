extends Node2D
class_name State

@onready var player = owner.get_parent().find_child("Player")
@onready var animation_player = owner.find_child("AnimationPlayer")

func _ready():
	pass

func enter():
	pass

func exit():
	pass

func transition():
	pass

func _physics_process(delta):
	transition()
