extends Control

@onready var message_label = $Label
@onready var restart_button = $RestartButton
@onready var exit_button = $ExitButton

func _ready():
	await get_tree().process_frame  # Asegurar que el layout se cargue bien
	ajustar_posiciones()  # Llamar a la función para centrar elementos al iniciar

func set_message(text):
	message_label.text = text
	ajustar_posiciones()  # Asegurar que se reubique cuando el mensaje cambie

func ajustar_posiciones():
	# Centrar el mensaje en pantalla
	message_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	message_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	message_label.size = Vector2(400, 100)
	message_label.position.x = (get_viewport_rect().size.x - message_label.size.x) / 2
	message_label.position.y = -10  # Ajusta según sea necesario

	# Centrar los botones horizontalmente
	restart_button.anchor_left = 0.5
	restart_button.anchor_right = 0.5
	restart_button.position.x = (get_viewport_rect().size.x - restart_button.size.x) / 2
	restart_button.position.y = message_label.position.y + 60  # Espacio debajo del mensaje

	exit_button.anchor_left = 0.5
	exit_button.anchor_right = 0.5
	exit_button.position.x = (get_viewport_rect().size.x - exit_button.size.x) / 2
	exit_button.position.y = restart_button.position.y + 40  # Espacio debajo de Reiniciar

func _on_restart_button_pressed():
	get_tree().paused = false  # Reanudar el juego
	get_tree().reload_current_scene()

func _on_exit_button_pressed():
	get_tree().quit()
