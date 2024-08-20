class_name Debugger extends Node2D

@export var player : CharacterBody2D

func _ready() -> void:
	player.gold += 10000000

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("g"):
		var ground_layer = get_tree().get_first_node_in_group("GroundLayer")
		var hovered_tile = ground_layer.local_to_map(get_global_mouse_position())
		var contraption_node = get_tree().get_first_node_in_group("ContraptionNode")
		contraption_node.erase_contraption(str(hovered_tile))
