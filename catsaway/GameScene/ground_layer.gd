extends TileMapLayer

var tile : Vector2i
@export var tiles : Node2D

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("LMB"):
		if TileManager.available_expansion_tiles.has(tile) and TileManager.highlighted == true:
			var select_layer = get_tree().get_first_node_in_group("SelectLayer")
			if select_layer.highlight_type == "Expansion":
				set_cells_terrain_connect([tile], 0, 0)
				TileManager.Land[str(tile)] = {
					"Contraption" : "None",
				}
				
				var new_tile: Tile = load("res://Tile/tile.tscn").instantiate()
				
	#			setting it up
				tiles.add_child(new_tile)
				new_tile.tile_name = str(tile)
				new_tile.position = map_to_local(tile)
				
				select_layer.erase_highlight()
			
	if Input.is_action_just_pressed("f"):
		set_cells_terrain_connect([tile], 0, -1)
		
func _ready() -> void:
	var starting_tile = local_to_map($"../../Player".global_position)
	var new_tile = load("res://Tile/tile.tscn").instantiate()
	
	tiles.add_child(new_tile)
	new_tile.tile_name = str(starting_tile)
	new_tile.position = map_to_local(starting_tile)
	
	
	TileManager.Land[str(starting_tile)] = {
			"Contraption" : "None",
		}

func _process(_delta: float) -> void:
	tile = local_to_map(get_global_mouse_position())
	
func erase_tile(tile_position: Vector2i):
	set_cells_terrain_connect([tile_position], 0, -1)
	TileManager.Land.erase(str(tile_position))
	
