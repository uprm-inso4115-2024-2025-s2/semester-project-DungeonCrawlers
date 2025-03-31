extends Node2D

class_name  room
# Hay que cambiar el tamnano del cuarto al coorecto
var room_size: Vector2 = Vector2(3, 3)  # Tamaño del room (ancho, alto)
var matrix = []
enum Side { TOP =1 , BOTTOM = 2, LEFT = 3, RIGHT = 4}
var corridors = []

func getScene():
	return get_tree().get_current_scene();

func getTopLeftCorner() -> Vector2: 
	return Vector2(0, 0);
func getTopRightCorner(): 
	return Vector2(room_size.x, 0)
func getBottomLeftCorner():
	return Vector2(0, room_size.y)
func getBottomRightCorner():
	return Vector2(room_size.x, room_size.y)
#func getTopLeftCorner(): 
	#return matrix[0][0];
#func getTopRightCorner(): 
	#return matrix[0][room_size.x]
#func getBottomLeftCorner():
	#return matrix[room_size.y][0]
#func getBottomRightCorner():
	#return matrix[room_size.y][room_size.x]
	
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
	#print(matrix)
	print(getTopRightCorner())
	print(getScene())
	print(getCorridors())
	pass
