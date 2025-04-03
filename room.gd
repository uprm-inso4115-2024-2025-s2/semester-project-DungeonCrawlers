extends Node2D

class_name  room
# Hay que cambiar el tamano del cuarto al correcto
var room_size: Vector2 = Vector2(44,46)  # Tamaño del room (ancho, alto)
var tile_size = 1;
var matrix = []
enum Side { TOP =1 , BOTTOM = 2, LEFT = 3, RIGHT = 4}
var corridors = []
var x = 0
var y = 0

func setxy(param_y, param_x ):
	x = param_x
	y = param_y

func getScene():
	return get_tree().get_current_scene();

func getTopLeftCorner(): 
	return Vector2((0-x)*tile_size, (0-y)*tile_size);
func getTopRightCorner(): 
	return Vector2((room_size.x-x)*tile_size, (0-y)*tile_size)
func getBottomLeftCorner():
	return Vector2((0-x)*tile_size, (room_size.y-y)*tile_size)
func getBottomRightCorner():
	return Vector2((room_size.x-x)*tile_size, (room_size.y-y)*tile_size)

func getCorridors() -> Array:
	return corridors; 

# Called when the node enters the scene tree for the first time.
# Example: Initialize corridors (can be done at runtime or based on some condition)

func _ready():
	#var array_1 = []
	#for a in range(room_size.x):
		#array_1.append(0)
		#
	#for a in range(room_size.y):
		#matrix.append(array_1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(x,y)
	#print(getBottomRightCorner())
	#print(getScene())
	pass
