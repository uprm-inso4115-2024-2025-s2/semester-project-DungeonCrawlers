extends Node2D

@onready var foreground_bar = $CanvasLayer/Control/Foregroundbar

var max_health := 100

func update_health(new_health: int) -> void:
	var health_percent = float(new_health) / max_health
	foreground_bar.size.x = health_percent * 100  # Or your bar's full width
	
	if health_percent > 0.6:
		foreground_bar.color = Color(0, 1, 0)  # Green
	elif health_percent > 0.3:
		foreground_bar.color = Color(1, 1, 0)  # Yellow
	else:
		foreground_bar.color = Color(1, 0, 0)  # Red
