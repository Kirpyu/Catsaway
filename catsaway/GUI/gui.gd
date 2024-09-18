extends Control

func _on_expansion_pressed() -> void:
	var select_layer = get_tree().get_first_node_in_group("SelectLayer")
	if select_layer.highlight_type == "Expansion":
		select_layer.erase_highlight()
	else:
		select_layer.highlight_tiles(TileManager.get_available_expansion_tiles(), "Expansion")
	

func _on_repair_pressed() -> void:
	var select_layer = get_tree().get_first_node_in_group("SelectLayer")
	select_layer.highlight_tiles(TileManager.get_tiles_with_contraption(), "Demolish")


func _on_upgrade_pressed() -> void:
	var select_layer = get_tree().get_first_node_in_group("SelectLayer")
	select_layer.highlight_tiles(TileManager.get_upgradable_tiles(), "Upgrade")


func _on_button_pressed() -> void:
	if %TutorialPanel.visible == false:
		%TutorialPanel.show()
	else:
		%TutorialPanel.hide()
