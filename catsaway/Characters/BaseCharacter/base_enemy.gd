class_name BaseEnemy
extends CharacterBody2D

@export var speed := 40
@export var max_hp := 30
@export var hp : int
@export var attack := 10
@export var hp_bar : ProgressBar
@export var animated_sprite : AnimatedSprite2D
@export var stop_timer : Timer
@export var death_sprite : AnimatedSprite2D

#flicker hitbox to make it attack every . something seconds
@export var hitbox_collision : CollisionShape2D

var stopped := false
var target : Tile


func _ready() -> void:
	get_closest_target()
	hp_bar.max_value = max_hp
	hp = max_hp
	update_hp()

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
	var drop = load("res://Contraptions/DropButtons/contraption_drop.tscn").instantiate()
	drop.drop_name = "YarnThrower"
	get_tree().root.add_child(drop)
	drop.position = self.global_position

func _on_death_sprite_2d_animation_finished() -> void:
	create_drop()
	queue_free()
