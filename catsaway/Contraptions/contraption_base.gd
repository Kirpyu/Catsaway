class_name Contraption
extends Node2D


@export var spawn_point : Marker2D
@export var shoot_cd : Timer
@export var animated_sprite : AnimatedSprite2D
var contraption_tile : String

#this should not be in base script, should be defined in every extended script
var projectile = preload("res://Projectiles/projectile_base.tscn")

var closest_enemy: BaseEnemy
	
func _process(_delta: float) -> void:
	if closest_enemy != null:
		look_at(closest_enemy.global_position)
		if shoot_cd.is_stopped():
			shoot_cd.start()
	else: 
		shoot_cd.stop()
		get_closest_target()

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
	var b = projectile.instantiate()
	get_tree().root.add_child(b)
	b.transform = spawn_point.global_transform


func _on_shoot_cooldown_timeout() -> void:
	shoot()
	
