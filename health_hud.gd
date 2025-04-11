extends Node2D

@onready var foreground_bar = $Control/Foregroundbar

var max_health = 100

func update_health(new_health):
	# Animate health bar width
	var health_percent = (float(max_health - new_health)*.20)
	foreground_bar.size.x = (foreground_bar.size.x - health_percent)
	max_health = new_health
	if max_health > (100*0.6):
		foreground_bar.color = Color(0, 255, 0)  # Green
	elif max_health > (100*0.3):
		foreground_bar.color = Color(255, 255, 0)  # Yellow
	else:
		foreground_bar.color = Color(255, 0, 0)  # Red
	# Change color based on health
