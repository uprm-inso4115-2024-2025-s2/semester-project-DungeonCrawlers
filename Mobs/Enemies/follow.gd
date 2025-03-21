extends State

var direction : Vector2
func enter():
	owner.set_direction(player.position - owner.position)
	animation_player.play("run")
func exit():
	super.exit()
	owner.set_direction(Vector2.ZERO)

func transition():
	if owner.direction.length() < 10:
		get_parent().change_state("attack")
