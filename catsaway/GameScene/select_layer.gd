extends TileMapLayer

var highlight_type : String = ""
var hihglight_types : Array[String] = ["Expansion", "Contraption"]

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("RMB"):
		highlight_tiles(TileManager.get_available_expansion_tiles(), "Expansion")
		
		
func highlight_tiles(tiles: Array[Vector2i], type: String):
	if TileManager.highlighted:
		clear()
		TileManager.highlighted = false
		highlight_type = ""
	else:
		for tile in tiles:
			set_cell(tile, 0, Vector2i(1,1), 0)
			
		TileManager.highlighted = true
		highlight_type = type

func erase_highlight():
	clear()
	highlight_type = ""
	TileManager.highlighted = false
#	highlighted false handled elsewhere, keep this in mind
