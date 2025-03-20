extends CharacterBody2D
class_name Boss

@onready var foreground_bar = $AnimatedSprite2D/Foreground_bar
@onready var animated_sprite = $AnimatedSprite2D
var Boss_health = 200
var Boss_attack = 15
var max_health = 200
var scnd_fase = 0.25

func get_Boss_health() -> int:
	return Boss_health
	
func set_Boss_health(Damage_to_take_away) ->void:
	Boss_health = max(0, Boss_health - Damage_to_take_away)

func _physics_process(delta):
	move_and_slide()
	if velocity.length() > 0:
		animated_sprite.play("Run")
	if velocity.x > 0:
		animated_sprite.flip_h = false
	if velocity.x < 0:
		animated_sprite.flip_h = true
	
func get_Boss_attack()-> int:
	return Boss_attack

func update_health(new_health):
	 #Animate health bar width
	var health_percent = (float(max_health - new_health)*.20)
	foreground_bar.size.x = (foreground_bar.size.x - health_percent)
	max_health = new_health
	if max_health > (100*0.6):
		foreground_bar.color = Color(0, 255, 0)  # Green
	elif max_health > (100*0.3):
		foreground_bar.color = Color(255, 255, 0)  # Yellow
	else:
		foreground_bar.color = Color(255, 0, 0)  # Red
	# Change color based on heal
