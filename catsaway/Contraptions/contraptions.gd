extends Node2D

var hovered_tile : Vector2i = Vector2i.ZERO
var held_contraption : String = ""
var held_drop : Button = null


func _ready() -> void:
	var ground_layer = get_tree().get_first_node_in_group("GroundLayer")
	var player_tile = get_tree().get_first_node_in_group("Player").global_position
	add_contraption(ContraptionManager.create_contraption("YarnThrower"), ground_layer.local_to_map(player_tile))

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("LMB"):
		var select_layer =  get_tree().get_first_node_in_group("SelectLayer")
		if TileManager.Land.has(str(hovered_tile)) and select_layer.highlight_type == "Contraption":
			for tile: Tile in get_tree().get_nodes_in_group("Tile"):
				if str(hovered_tile) == tile.tile_name:
					var contraption = TileManager.Land[tile.tile_name]["Contraption"]
					if contraption == "None":
#						instantiate a contraption at tile.global_position
						add_contraption(ContraptionManager.create_contraption(held_contraption), hovered_tile)
						TileManager.Land[tile.tile_name]["Contraption"] = held_contraption
						
#						deleting everything that j happened
						select_layer.erase_highlight()
						held_drop.queue_free()
					else:
						pass
					return

func _process(_delta: float) -> void:
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

func delete_drop(drop: Button):
	drop.queue_free()

func handle_drop(drop: Button):
	var select_layer =  get_tree().get_first_node_in_group("SelectLayer")
	if held_contraption == "" and held_drop == null:
		held_contraption = drop.drop_name
		held_drop = drop
		select_layer.highlight_tiles(TileManager.get_available_contraption_tiles(), "Contraption")
	else:
		select_layer.erase_highlight()
		held_contraption = ""
		held_drop = null
	
