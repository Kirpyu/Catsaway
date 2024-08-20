class_name BaseEnemy
extends CharacterBody2D

@export var enemy_resource: EnemyResource
@export var hp : int
@export var hp_bar : ProgressBar
@export var animated_sprite : AnimatedSprite2D
@export var stop_timer : Timer
@export var death_sprite : AnimatedSprite2D
@export var fish_name: String

#flicker hitbox to make it attack every . something seconds
@export var hitbox_collision : CollisionShape2D
@onready var speed = enemy_resource.speed
var stopped := false
var target : Tile

func reset() -> void:
	pass

func _ready() -> void:
	get_closest_target()
	hp_bar.max_value = enemy_resource.max_hp
	hp = enemy_resource.max_hp
	update_hp()
	
	var ground_layer = get_tree().get_first_node_in_group("GroundLayer")
	var current_pos = ground_layer.local_to_map(self.global_position)
	if TileManager.Land.get(str(current_pos)) != null:
		get_tree().get_first_node_in_group("EnemySpawner").spawn_enemy(fish_name)

func hit(damage: int):
	hp -= damage;
	update_hp()
	
func update_hp():
	if hp <= 0:
		queue_free()
	hp_bar.value = hp

func get_closest_target():
	var shortest_distance = 0
	for tile: Tile in get_tree().get_nodes_in_group("Tile"):
		var target_direction = tile.global_position - self.global_position
		if shortest_distance == 0:
			shortest_distance = target_direction.length()
			target = tile
		elif target_direction.length() < shortest_distance:
			target = tile
			
func _process(_delta: float) -> void:
	if target == null:
		get_closest_target()
	elif !stopped:
		var direction = target.global_position - self.global_position
		velocity = direction.normalized() * speed 
		move_and_slide()
		look_at(target.global_position)


func _on_hitbox_area_entered(_area: Area2D) -> void:
	pass
	


func _on_stop_timer_timeout() -> void:
	pass
#	drop a button which queues free after 10 secs. on button click, gain a building in inventory

func create_drop():
	var rng = RandomNumberGenerator.new()
#	make that multiplactive with the wave number in the future
	var spawn_wave_number = 0
	if get_tree().get_first_node_in_group("EnemySpawner") != null:
		spawn_wave_number = get_tree().get_first_node_in_group("EnemySpawner").current_wave
	
	var rand_num = rng.randi_range(1, 10 + spawn_wave_number)
	if rand_num == 1:
		var drop = load("res://Contraptions/DropButtons/contraption_drop.tscn").instantiate()
		
		drop.drop_name = ContraptionManager.contraption_dic.keys().pick_random()
		get_parent().add_child(drop)
		drop.position = self.global_position

func drop_gold():
	var player = get_tree().get_first_node_in_group("Player")
	player.gold += enemy_resource.gold_given

func _on_death_sprite_2d_animation_finished() -> void:
	create_drop()
	drop_gold()
	queue_free()
