extends Control

# Nodes
@onready var audio_button = $VBoxContainer/AudioButton
@onready var controls_button = $VBoxContainer/ControlsButton
@onready var graphics_button = $VBoxContainer/GraphicsButton
@onready var return_button = $VBoxContainer/ReturnButton
@onready var animation_player = $AnimationPlayer
@onready var settings_container = $SettingsContainer  # Placeholder for new UI scenes

# Signals
signal settings_changed

# Paths to scenes
const AUDIO_SCENE = "res://UI/AudioSettings.tscn"
const CONTROLS_SCENE = "res://UI/ControlSettings.tscn"
const GRAPHICS_SCENE = "res://UI/GraphicsSettings.tscn"

func _ready():
	audio_button.pressed.connect(_on_audio_pressed)
	controls_button.pressed.connect(_on_controls_pressed)
	graphics_button.pressed.connect(_on_graphics_pressed)
	return_button.pressed.connect(_on_return_pressed)
	
	# Play fade-in animation on start
	animation_player.play("fade_in")

func _on_audio_pressed():
	_load_settings_scene(AUDIO_SCENE)

func _on_controls_pressed():
	_load_settings_scene(CONTROLS_SCENE)

func _on_graphics_pressed():
	_load_settings_scene(GRAPHICS_SCENE)

func _on_return_pressed():
	print("Returning to previous screen")
	animation_player.play("fade_out")

	# Wait for animation to finish before switching UI
	await animation_player.animation_finished
	
	# Remove the current settings screen
	for child in settings_container.get_children():
		child.queue_free()

	# Show the main settings menu again
	$VBoxContainer.visible = true  # Show buttons again

# Function to load different settings UIs
func _load_settings_scene(scene_path):
	print("Loading scene:", scene_path)

	# Instead of hiding the whole SettingsMenu, hide only the button container
	$VBoxContainer.visible = false  # Hides the buttons but keeps SettingsContainer visible

	# Remove existing children in SettingsContainer
	for child in settings_container.get_children():
		print("Removing child:", child.name)
		child.queue_free()

	# Load and instantiate the new settings scene
	var new_scene = load(scene_path).instantiate()

	if new_scene:
		print("Scene loaded successfully:", scene_path)
	else:
		print("Error loading scene:", scene_path)
		return

	# Ensure it takes up the full screen
	new_scene.visible = true
	new_scene.set_position(Vector2.ZERO)
	
	if new_scene is Control:
		new_scene.set_anchors_preset(Control.PRESET_FULL_RECT)
		new_scene.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		new_scene.size_flags_vertical = Control.SIZE_EXPAND_FILL
		new_scene.set_size(settings_container.size)  # Match parent container size

	# Add to SettingsContainer
	settings_container.add_child(new_scene)
	await get_tree().process_frame  # Ensure UI updates

	# Debugging output
	print("Children count in settings_container AFTER adding:", settings_container.get_child_count())
	print("New scene visibility:", new_scene.visible, "Size:", new_scene.size)
