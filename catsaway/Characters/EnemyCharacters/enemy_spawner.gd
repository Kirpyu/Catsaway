extends Path2D

@export var spawn_randomizer : PathFollow2D
@export var spawn_pos : Marker2D
var current_wave = 1

@onready var normal_fish = preload("res://Characters/EnemyCharacters/normal_fish.tscn")
@onready var paper_cup_fish = preload("res://Characters/EnemyCharacters/PaperCupFish/paper_cup_fish.tscn")
@onready var coquette_fish = preload("res://Characters/EnemyCharacters/CoquetteFish/coquette_fish.tscn")
@onready var flying_fish = preload("res://Characters/EnemyCharacters/FlyingFish/flying_fish.tscn")
@onready var projectile_fish = preload("res://Characters/EnemyCharacters/ProjectileFish/projectile_fish.tscn")

var random_fish : Array
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _process(delta: float) -> void:
	random_fish.append(normal_fish)
#	match wave:
# 5 spawn papercone fish
func _on_normal_fish_spawner_timeout() -> void:
	spawn_enemy(normal_fish)

func _on_paper_cup_fish_spawner_timeout() -> void:
	pass # Replace with function body.


func _on_coquette_fish_spawner_timeout() -> void:
	pass # Replace with function body.


func _on_flying_fish_spawner_timeout() -> void:
	pass # Replace with function body.


func _on_projectile_fish_spawner_timeout() -> void:
	pass # Replace with function body.


func _on_random_fish_spawner_timeout() -> void:
	var new_fish = random_fish.pick_random().instantiate()

func spawn_enemy(enemy):
	spawn_randomizer.progress_ratio = rng.randf_range(0,1)
	var new_enemy = enemy.instantiate()
	get_tree().root.add_child(new_enemy)
	new_enemy.global_position = spawn_pos.global_position
