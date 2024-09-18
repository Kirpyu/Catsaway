extends Node2D

const pop_up_text : String = "res://Dialogue/pop_up_text.tscn"
var step : int = 1
var starting_tile : Vector2i
var dialogue : PopUpText
@onready var surrounding_tiles : Array[String] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ground_layer = get_tree().get_first_node_in_group("GroundLayer")
	starting_tile = ground_layer.local_to_map(%Player.global_position)
	dialogue = load(pop_up_text).instantiate()
	dialogue.setup_script(DialogueManager.tutorial_start_dialogue)
	%CanvasLayer.add_child(dialogue)
	
	for surrounding_tile in ground_layer.get_surrounding_cells(starting_tile):
			surrounding_tiles.append(str(surrounding_tile))
	
func _process(delta: float) -> void:
	var select_layer = get_tree().get_first_node_in_group("SelectLayer")
	match step:
		1:
			select_layer.simple_highlight(select_layer.get_surrounding_cells(starting_tile))
			if TileManager.Land.has_all(surrounding_tiles):
				next_step()
		2:
			pass

func next_step():
	step += 1
	match step:
		2:
			var select_layer = get_tree().get_first_node_in_group("SelectLayer")
			select_layer.erase_highlight()
			dialogue.setup_script(DialogueManager.placed_tile_dialogue)
			
			
	
