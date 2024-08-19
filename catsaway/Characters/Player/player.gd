extends CharacterBody2D

var direction :Vector2 = Vector2.ZERO
@export var movespeed := 50
@export var animated_sprite : AnimatedSprite2D
@export var gold : int = 0

func _physics_process(_delta):
	direction = Input.get_vector("left","right","up","down").normalized()
	set_velocity(direction * movespeed)
	move_and_slide()
	direction = velocity
	
	if velocity == Vector2.ZERO:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walking")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("LMB"):
		var ground_layer = get_tree().get_first_node_in_group("GroundLayer")
		var hovered_tile = ground_layer.local_to_map(get_global_mouse_position())
		var select_layer =  get_tree().get_first_node_in_group("SelectLayer")
		if select_layer.highlight_type == "Expansion":
			if TileManager.available_expansion_tiles.has(hovered_tile):
				ground_layer.set_cells_terrain_connect([hovered_tile], 0, 0)
				TileManager.Land[str(hovered_tile)] = {
					"Contraption" : "None",
				}
				
				var new_tile: Tile = load("res://Tile/tile.tscn").instantiate()
				
	#			setting it up
				ground_layer.tiles.add_child(new_tile)
				new_tile.tile_name = str(hovered_tile)
				new_tile.position = ground_layer.map_to_local(hovered_tile)
				
				select_layer.erase_highlight()
				
		if select_layer.highlight_type == "Contraption":
			if TileManager.Land.has(str(hovered_tile)):
				for tile: Tile in get_tree().get_nodes_in_group("Tile"):
					if str(hovered_tile) == tile.tile_name:
						var contraption = TileManager.Land[tile.tile_name]["Contraption"]
						var contraption_node = get_tree().get_first_node_in_group("ContraptionNode")
						if contraption == "None":
							contraption_node.add_contraption(ContraptionManager.create_contraption(contraption_node.held_contraption), hovered_tile)
							TileManager.Land[tile.tile_name]["Contraption"] = contraption_node.held_contraption
							
							select_layer.erase_highlight()
							#$AudioStreamPlayer.play()
							contraption_node.held_contraption = ""
							contraption_node.held_drop.queue_free()
						return
	
	if Input.is_action_just_pressed("right"):
		animated_sprite.flip_h = true
	
	if Input.is_action_just_pressed("left"):
		animated_sprite.flip_h = false
		

#make the player lose when they touch the water
