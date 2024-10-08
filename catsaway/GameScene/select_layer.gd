extends TileMapLayer

var highlight_type : String = ""
const highlight_types : Array[String] = ["Expansion", "Contraption", "Upgrade"]
		
func highlight_tiles(tiles: Array[Vector2i], type: String):
	if TileManager.highlighted:
		clear()
		TileManager.highlighted = false
		highlight_type = ""
	else:
		for tile in tiles:
			set_cell(tile, 3, Vector2i(0,0), 0)
			
		TileManager.highlighted = true
		highlight_type = type

func erase_highlight():
	clear()
	highlight_type = ""
	TileManager.highlighted = false
#	highlighted false handled elsewhere, keep this in mind
