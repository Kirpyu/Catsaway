extends Control

func _on_expansion_pressed() -> void:
	var select_layer = get_tree().get_first_node_in_group("SelectLayer")
	select_layer.highlight_tiles(TileManager.get_available_expansion_tiles(), "Expansion")

func _on_repair_pressed() -> void:
	pass # Replace with function body.wwwww
