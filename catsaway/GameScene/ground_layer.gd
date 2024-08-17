extends TileMapLayer

var tile : Vector2i

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("LMB"):
		set_cells_terrain_connect([tile], 0, 0)


func _process(_delta: float) -> void:
	tile = local_to_map(get_global_mouse_position())
	
	
