extends TileMapLayer

@export var tiles : Node2D
@export var size_x = 200
@export var size_y = 50
@onready var tile = preload("res://Tile/tile.tscn")
func _ready() -> void:
	
	
	for x in size_x:
		for y in size_y:
			var new_tile = tile.instantiate()
			tiles.add_child(new_tile)
			new_tile.tile_name = str(Vector2i(x,y))
			new_tile.position = map_to_local(Vector2i(x,y))
