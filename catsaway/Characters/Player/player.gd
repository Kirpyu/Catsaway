extends CharacterBody2D

var direction :Vector2 = Vector2.ZERO
@export var movespeed := 50
@export var animated_sprite : AnimatedSprite2D
@onready var gold : int = 0
@onready var tiles_created: float = 0

@export var settings_scene : Control

@onready var tile_base_cost: float = 20
@onready var tile_cost: int :
	get:
		return tile_base_cost + floor(tile_base_cost * tiles_created/3 + 1.0)

func _process(_delta: float) -> void:
	var starting_tile = get_tree().get_first_node_in_group("GroundLayer").local_to_map(self.global_position)
	if TileManager.Land.get(str(starting_tile)) == null:
		die()
	
func _physics_process(_delta):
	direction = Input.get_vector("left","right","up","down").normalized()
	set_velocity(direction * movespeed)
	move_and_slide()
	direction = velocity
	
	if velocity == Vector2.ZERO:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walking")
		

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		settings_scene.set_paused(true)
		
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("LMB"):
		var ground_layer = get_tree().get_first_node_in_group("GroundLayer")
		var hovered_tile = ground_layer.local_to_map(get_global_mouse_position())
		var select_layer =  get_tree().get_first_node_in_group("SelectLayer")
		if select_layer.highlight_type == "Expansion":
			if TileManager.available_expansion_tiles.has(hovered_tile):
				if gold >= tile_cost:
#					check if gold is enough, then subtract it if enough and add to tiles creates
					gold -= tile_cost
					tiles_created += 1

					ground_layer.set_cells_terrain_connect([hovered_tile], 0, 0)
					TileManager.Land[str(hovered_tile)] = {
						"Contraption" : "None",
						"Type" : "",
						"Level" : 1
					}
					
					var new_tile: Tile = load("res://Tile/tile.tscn").instantiate()
					
		#			setting it up
					ground_layer.tiles.add_child(new_tile)
					new_tile.tile_name = str(hovered_tile)
					new_tile.position = ground_layer.map_to_local(hovered_tile)
					
					select_layer.erase_highlight()
					select_layer.highlight_tiles(TileManager.get_available_expansion_tiles(), "Expansion")
					
					%Expansion.play()
				
		if select_layer.highlight_type == "Contraption":
			if TileManager.Land.has(str(hovered_tile)):
				for tile: Tile in get_tree().get_nodes_in_group("Tile"):
					if str(hovered_tile) == tile.tile_name:
						var contraption = TileManager.Land[tile.tile_name]["Contraption"]
						var contraption_node = get_tree().get_first_node_in_group("ContraptionNode")
						if contraption == "None":
							contraption_node.add_contraption(ContraptionManager.create_contraption(contraption_node.held_contraption), hovered_tile)
							TileManager.Land[tile.tile_name]["Contraption"] = contraption_node.held_contraption
							TileManager.Land[tile.tile_name]["Type"] = "Main"
							
							select_layer.erase_highlight()
							#$AudioStreamPlayer.play()
							contraption_node.held_contraption = ""
							contraption_node.held_drop.queue_free()
							%Build.play()
						return
						
		if select_layer.highlight_type == "Upgrade":
			if TileManager.Land.has(str(hovered_tile)):
				var contraption = TileManager.Land[str(hovered_tile)]["Contraption"]
				var contraption_node = get_tree().get_first_node_in_group("ContraptionNode")
				if contraption != "None" and TileManager.Land[str(hovered_tile)]["Type"] == "Main":
					contraption_node.upgrade_contraption(hovered_tile)
		
		if select_layer.highlight_type == "UpgradeMain":
			var contraption_node = get_tree().get_first_node_in_group("ContraptionNode")
			var sacrificial_tiles = contraption_node.sacrificial_tiles
			
			if contraption_node.sacrificial_tiles.has(hovered_tile):
				var hovered_tile_name = TileManager.Land[str(hovered_tile)]["Contraption"]
				if TileManager.Land[str(contraption_node.main_tile)]["Level"] < 5:
					TileManager.Land[str(contraption_node.main_tile)]["Level"] += 1
					
				TileManager.Land[str(hovered_tile)]["Contraption"] = "None"
				TileManager.Land[str(hovered_tile)]["Type"] = ""
				contraption_node.erase_contraption(str(hovered_tile))
				
				contraption_node.add_contraption(ContraptionManager.create_sacrifice(hovered_tile_name), hovered_tile)
				TileManager.Land[str(hovered_tile)]["Contraption"] = hovered_tile_name
				TileManager.Land[str(hovered_tile)]["Type"] = "Secondary" 
				select_layer.erase_highlight()
#				erase that tile, replace w new tile
				%Expansion.play()
				sacrificial_tiles = []
				contraption_node.main_tile = Vector2i.ZERO
#			turn it into a secondary thing, add a level, clear sacrificial tiles, remove highlights
		if TileManager.Land.has(str(hovered_tile)):
			print(TileManager.Land[str(hovered_tile)])
	
		if select_layer.highlight_type == "Demolish":
			if TileManager.Land.has(str(hovered_tile)):
				TileManager.Land[str(hovered_tile)]["Contraption"] = "None"
				TileManager.Land[str(hovered_tile)]["Type"] = "" 
				TileManager.Land[str(hovered_tile)]["Level"] = 1
				var contraption_node = get_tree().get_first_node_in_group("ContraptionNode")
				contraption_node.erase_contraption(str(hovered_tile))
				%Demolish.play()
			select_layer.erase_highlight()
			
	if Input.is_action_just_pressed("right"):
		animated_sprite.flip_h = true
	
	if Input.is_action_just_pressed("left"):
		animated_sprite.flip_h = false
		
func die():
	var end_screen = %EndScreen
	end_screen.show()
	end_screen.set_paused(true)
#make the player lose when they touch the water


func _on_gold_regen_timeout() -> void:
	gold += 1
