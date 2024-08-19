extends Path2D

@export var spawn_randomizer : PathFollow2D
@export var spawn_pos : Marker2D
var current_wave = 1

@onready var normal_fish = preload("res://Characters/EnemyCharacters/normal_fish.tscn")
@onready var paper_cup_fish = preload("res://Characters/EnemyCharacters/PaperCupFish/paper_cup_fish.tscn")
@onready var coquette_fish = preload("res://Characters/EnemyCharacters/CoquetteFish/coquette_fish.tscn")
@onready var flying_fish = preload("res://Characters/EnemyCharacters/FlyingFish/flying_fish.tscn")
@onready var projectile_fish = preload("res://Characters/EnemyCharacters/ProjectileFish/projectile_fish.tscn")

const normal_fish_res = "res://Characters/EnemyCharacters/normal_fish.tres"
const paper_cup_fish_res = "res://Characters/EnemyCharacters/PaperCupFish/paper_cup_fish.tres"
const coquette_fish_res = "res://Characters/EnemyCharacters/CoquetteFish/coquette_fish.tres"
const flying_fish_res = "res://Characters/EnemyCharacters/FlyingFish/flying_fish.tres"
const projectile_fish_res = "res://Characters/EnemyCharacters/ProjectileFish/projectile_fish.tres"


@export var normal_fish_spawner : Timer
@export var paper_cup_fish_spawner : Timer
@export var coquette_fish_spawner : Timer
@export var flying_fish_spawner : Timer
@export var projectile_fish_spawner : Timer
@export var random_fish_spawner : Timer

var random_fish : Array
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _process(delta: float) -> void:
	random_fish.append(normal_fish)
#	match wave:
# 5 spawn papercone fish
func _on_normal_fish_spawner_timeout() -> void:
	spawn_enemy(normal_fish)

func _on_paper_cup_fish_spawner_timeout() -> void:
	spawn_enemy(paper_cup_fish)


func _on_coquette_fish_spawner_timeout() -> void:
	spawn_enemy(coquette_fish)


func _on_flying_fish_spawner_timeout() -> void:
	spawn_enemy(flying_fish)


func _on_projectile_fish_spawner_timeout() -> void:
	spawn_enemy(projectile_fish)


func _on_random_fish_spawner_timeout() -> void:
	var new_fish = random_fish.pick_random()
	spawn_enemy(new_fish)

func spawn_enemy(enemy):
	spawn_randomizer.progress_ratio = rng.randf_range(0,1)
	var new_enemy = enemy.instantiate()
	get_tree().root.add_child(new_enemy)
	new_enemy.global_position = spawn_pos.global_position

func _on_wave_timer_timeout() -> void:
	if current_wave < 40:
		current_wave += 1
	wave_change()

func wave_change() -> void:
	match current_wave:
		2:
			paper_cup_fish_spawner.start()
			normal_fish_spawner.wait_time = 2.5
			
		3:
			random_fish.append(paper_cup_fish)
			load(normal_fish_res).max_hp += 5
		4:
			random_fish_spawner.wait_time = 4.5
		
		5:
			load(normal_fish_res).speed += 10
		
		6:
			flying_fish_spawner.start()
			
		7:
			paper_cup_fish_spawner.wait_time = 2.5
			normal_fish_spawner.wait_time = 2
		8: 
			flying_fish_spawner.wait_time = 4
		
		10:
			load(flying_fish_res).max_hp += 10
			load(flying_fish_res).speed += 10
			flying_fish_spawner.wait_time = 1
		
		11:
			flying_fish_spawner.wait_time = 3.75
			
		12:
			paper_cup_fish_spawner.wait_time = 2
		
		14:
			projectile_fish_spawner.start()
			random_fish_spawner.append(coquette_fish)
		
		15:
			load("res://Characters/EnemyCharacters/normal_fish.tres").max_hp += 10
			load("res://Characters/EnemyCharacters/normal_fish.tres").speed += 10
			normal_fish_spawner.wait_time = .5
		
		16: 
			load(paper_cup_fish_res).max_hp += 10
			normal_fish_spawner.wait_time = 1.8
		
		17:
			load(projectile_fish_res).max_hp += 10
			random_fish_spawner.wait_time = 3
		
		18:
			load(normal_fish_res).max_hp += 10
			random_fish_spawner.append(projectile_fish)
		
		20:
			coquette_fish_spawner.start()
		
		21:
			normal_fish_spawner.wait_time = 1.5
			load(flying_fish).max_hp += 10
		
		22:
			flying_fish_spawner.wait_time = 3
		
		23:
			load(flying_fish_res).speed += 5
			load(flying_fish_res).damage += 10
			load(flying_fish_res).hp += 10
		
		24:
			load(projectile_fish_res).attack += 5
			projectile_fish_spawner.wait_time = .3
		
		25: 
			projectile_fish_spawner.wait_time = 2
			
		26:
			load(coquette_fish_res).speed += 5
			coquette_fish_spawner.wait_time = 3
			
			
