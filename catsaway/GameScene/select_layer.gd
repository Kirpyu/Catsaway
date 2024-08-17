extends TileMapLayer

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("RMB"):
		if TileManager.highlighted:
			clear()
			TileManager.highlighted = false
		else:
			for tile in TileManager.get_available_expansion_tiles():
				set_cell(tile, 0, Vector2i(1,1), 0)
				
			TileManager.highlighted = true
	
	if Input.is_action_just_pressed("LMB"):
		clear()
		
