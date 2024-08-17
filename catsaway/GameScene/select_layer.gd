extends TileMapLayer

var highlighted := false
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("RMB"):
		if highlighted:
			for tile in TileManager.get_available_expansion_tiles():
				erase_cell(tile)
		else:
			for tile in TileManager.get_available_expansion_tiles():
				set_cell(tile, 0, Vector2i(1,1), 0)
	
	if Input.is_action_just_pressed("LMB"):
		for tile in TileManager.get_available_expansion_tiles():
			erase_cell(tile)
