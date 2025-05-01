extends Node2D

const MAP_WIDTH = 10
const MAP_HEIGHT = 10
const ROOM_SPACING = 576

var room_scenes = {}
var dungeon_grid = []
var visited = {}

func _ready():
	randomize()
	# Load only valid room scenes (all must extend your `room` class)
	room_scenes[1] = load("res://Rooms/Room 1.tscn") # all directions
	room_scenes[3] = load("res://Rooms/Room 3.tscn") # up, right, down
	room_scenes[4] = load("res://Rooms/Room 4.tscn") # up, right, left, down

	# Initialize 10x10 grid with " 0 "
	for y in range(MAP_HEIGHT):
		var row = []
		for x in range(MAP_WIDTH):
			row.append(" 0 ")
		dungeon_grid.append(row)

	# Start dungeon generation from center
	var start_pos = Vector2i(MAP_WIDTH / 2, MAP_HEIGHT / 2)
	generate_path(start_pos, 0)

	# Place the rooms and print the grid
	place_rooms()
	print_dungeon_grid()

# Recursive path generation
func generate_path(pos: Vector2i, room_count: int) -> void:
	if room_count >= 27:
		return

	if not is_in_bounds(pos):
		return
	if str(pos) in visited:
		return

	var room_type = choose_room_type(pos)
	dungeon_grid[pos.y][pos.x] = " " + str(room_count) + " "
	visited[str(pos)] = room_type

	var directions = [Vector2i(0, -1), Vector2i(1, 0), Vector2i(0, 1), Vector2i(-1, 0)]
	directions.shuffle()

	for dir in directions:
		var next = pos + dir
		if is_in_bounds(next) and str(next) not in visited and randi() % 100 < 65:
			generate_path(next, room_count + 1)

# Random room type from available
func choose_room_type(pos: Vector2i) -> int:
	var options = [1, 3, 4]
	return options[randi() % options.size()]

# Places each room using your room class
func place_rooms():
	for y in range(MAP_HEIGHT):
		for x in range(MAP_WIDTH):
			var room_label = dungeon_grid[y][x]
			if room_label != " 0 ":
				var index = int(room_label.strip_edges())
				var room_type = visited[str(Vector2i(x, y))]
				var scene = room_scenes.get(room_type)
				if scene:
					var room_instance = scene.instantiate()
					
					# Make sure it’s cast as your room class before using custom logic
					if room_instance is room:
						room_instance = room_instance as room
						room_instance.setxy(y, x)

					room_instance.global_position = Vector2(x * ROOM_SPACING, y * ROOM_SPACING)
					add_child(room_instance)

# Checks if coordinates are inside map bounds
func is_in_bounds(pos: Vector2i) -> bool:
	return pos.x >= 0 and pos.x < MAP_WIDTH and pos.y >= 0 and pos.y < MAP_HEIGHT

# Print final dungeon grid
func print_dungeon_grid():
	print("printing map.")
	for row in dungeon_grid:
		print(row)
