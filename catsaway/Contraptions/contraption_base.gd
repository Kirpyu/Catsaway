class_name Contraption
extends Node2D

@export var contraption_tile : String
@export var spawn_point : Marker2D
@export var shoot_cd : Timer

var closest_enemy: BaseEnemy

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if closest_enemy != null:
		look_at(closest_enemy.global_position)

func get_closest_target():
	var shortest_distance = 0
	for enemy : BaseEnemy in get_tree().get_nodes_in_group("Enemy"):
		var target_direction = enemy.global_position - self.global_position
		if shortest_distance == 0:
			shortest_distance = target_direction.length()
			closest_enemy = enemy
		elif target_direction.length() < shortest_distance:
			closest_enemy = enemy

func shoot():
	get_closest_target()


func _on_shoot_cooldown_timeout() -> void:
	shoot()
