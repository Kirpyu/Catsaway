extends Node

var Land := {}
@export var highlighted := false
var available_expansion_tiles : Array[Vector2i]= []

func get_available_expansion_tiles() -> Array[Vector2i]:
	available_expansion_tiles.clear()
	
	for tile in Land:
		var temp_array = []
		temp_array.append(Vector2i(string_to_vector2(tile).x + 1, string_to_vector2(tile).y))
		temp_array.append(Vector2i(string_to_vector2(tile).x - 1, string_to_vector2(tile).y))
		temp_array.append(Vector2i(string_to_vector2(tile).x, string_to_vector2(tile).y + 1))
		temp_array.append(Vector2i(string_to_vector2(tile).x, string_to_vector2(tile).y - 1))
		
		for vector in temp_array:
			if !available_expansion_tiles.has(vector) and !Land.has(str(vector)):
				available_expansion_tiles.append(vector)
	
	return available_expansion_tiles
	
static func string_to_vector2(string := "") -> Vector2i:
	if string:
		var new_string: String = string
		new_string = new_string.erase(0, 1)
		new_string = new_string.erase(new_string.length() - 1, 1)
		var array: Array = new_string.split(", ")

		return Vector2i(int(array[0]), int(array[1]))

	return Vector2i.ZERO
