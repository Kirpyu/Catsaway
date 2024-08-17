extends Node2D

var hovered_tile : Vector2i = Vector2i.ZERO

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("g"):
		if TileManager.Land.has(str(hovered_tile)):
			for tile: Tile in get_tree().get_nodes_in_group("Tile"):
				if str(hovered_tile) == tile.tile_name:
					var contraption = TileManager.Land[tile.tile_name]["Contraption"]
					if contraption == "None":
#						instantiate a contraption at tile.global_position
						add_contraption(ContraptionManager.create_contraption("BaseContraption"), hovered_tile)
						TileManager.Land[tile.tile_name]["Contraption"] = "BaseContraption"
					else:
						pass
#						pass, do not need this but you can throw a label ig, demolish option maybe
					return

func _process(delta: float) -> void:
	hovered_tile = get_tree().get_first_node_in_group("GroundLayer").local_to_map(get_global_mouse_position())
	
func add_contraption(contraption: Contraption, coordinates: Vector2i) -> void:
	add_child(contraption)
	contraption.contraption_tile = str(coordinates)
	contraption.position = get_tree().get_first_node_in_group("GroundLayer").map_to_local(coordinates)

func erase_contraption(coordinates: String) -> void:
	for contraption : Contraption in get_tree().get_nodes_in_group("Contraption"):
		if contraption.contraption_tile == coordinates:
			contraption.queue_free()
			return
