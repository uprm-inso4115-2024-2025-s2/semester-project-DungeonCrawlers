extends Node2D


@onready var canvas_layer = $CanvasLayer 

func _process(delta):
	if Input.is_action_just_pressed("ui_m"):
		canvas_layer.visible = !canvas_layer.visible
