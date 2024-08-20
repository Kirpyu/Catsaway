extends Node2D

var hovered_tile : Vector2i = Vector2i.ZERO
var held_contraption : String = ""
var held_drop : Button = null
var sacrificial_tiles : Array[Vector2i] = []
var main_tile : Vector2i = Vector2i.ZERO
# this is used for upgrades, while held is used for button drops
var hovered_contraption: String = ""

func _ready() -> void:
	var ground_layer = get_tree().get_first_node_in_group("GroundLayer")
	var player_tile = get_tree().get_first_node_in_group("Player").global_position
	add_contraption(ContraptionManager.create_contraption("YarnThrower"), ground_layer.local_to_map(player_tile))

func _process(_delta: float) -> void:
	hovered_tile = get_tree().get_first_node_in_group("GroundLayer").local_to_map(get_global_mouse_position())
	
func add_contraption(contraption: Contraption, coordinates: Vector2i) -> void:
	add_child(contraption)
	contraption.contraption_tile = str(coordinates)
	contraption.position = get_tree().get_first_node_in_group("GroundLayer").map_to_local(coordinates)

func erase_contraption(coordinates: String) -> void:
	for contraption : Contraption in get_tree().get_nodes_in_group("Contraption"):
		if contraption.contraption_tile == coordinates:
			#TileManager.Land[coordinates]["Contraption"] = "None"
			#TileManager.Land[coordinates]["Type"] = ""
			contraption.queue_free()
			return

func upgrade_contraption(coordinates: Vector2i) -> void:
	var temp_array : Array[Vector2i] = []
#	place all the tiles within the upgrade pattern here, then go thjrough all contraptions and check if tiles exists
#   better way to do it is to get the key within the dictionary instead of looping throuhg all tiles then checking if contraption = contraption name
#  if turned into a secondary upgrade, keep track of main tile
# when destroyed, if self is secondary upgrade, get main upgrade tile then subtract a level
	var upgrade_pattern = [] 
	var upgrade_contraption_name = TileManager.Land[str(coordinates)]["Contraption"]
	upgrade_pattern = ContraptionManager.contraption_dic[upgrade_contraption_name]["Pattern"]
	for pattern in upgrade_pattern:
		var contraption_in_pattern = Vector2i(coordinates.x + pattern.x, coordinates.y + pattern.y)
		if TileManager.Land.has(str(contraption_in_pattern)):
#			really long if just checks 2 conditions: if they are the same contraptions, if they are a main contraption
			if TileManager.Land[str(contraption_in_pattern)]["Contraption"] == upgrade_contraption_name and TileManager.Land[str(contraption_in_pattern)]["Type"] == "Main":
				if TileManager.Land[str(contraption_in_pattern)]["Level"] == 1:
					temp_array.append(contraption_in_pattern)
				
	var select_layer = get_tree().get_first_node_in_group("SelectLayer")
	select_layer.erase_highlight()
	if temp_array != []:
		print(temp_array)
		select_layer.highlight_tiles(temp_array, "UpgradeMain")
		sacrificial_tiles = temp_array
		main_tile = coordinates
	
func delete_drop(drop: Button):
	drop.queue_free()

func handle_drop(drop: Button):
	var select_layer =  get_tree().get_first_node_in_group("SelectLayer")
	if held_contraption == "" and held_drop == null and select_layer.highlight_type != "Expansion":
		held_contraption = drop.drop_name
		held_drop = drop
		select_layer.highlight_tiles(TileManager.get_available_contraption_tiles(), "Contraption")
	else:
		select_layer.erase_highlight()
		held_contraption = ""
		held_drop = null
	
