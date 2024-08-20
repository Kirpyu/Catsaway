extends Contraption

func _ready() -> void:
	projectile = load("res://Projectiles/CheeseBomb/cheese_bomb.tscn")

func _process(_delta: float) -> void:
	if closest_enemy != null:
		look_at(closest_enemy.global_position)
		if shoot_cd.is_stopped():
			shoot_cd.start()
			animated_sprite.play("shooting")
	else: 
		shoot_cd.stop()
		animated_sprite.play("stop")
		get_closest_target()

func shoot():
	get_closest_target()
	var b = projectile.instantiate()
	get_tree().root.add_child(b)
	b.transform = spawn_point.global_transform
	
	match TileManager.Land[contraption_tile]["Level"]:
		2:
			shoot_cd.wait_time = 1.75
			b.damage += 20
			b.scale = Vector2(2,2)
		3:
			shoot_cd.wait_time = 1.5
			b.damage += 40
		4:
			shoot_cd.wait_time = 1.25
			b.damage += 60
		5:
			shoot_cd.wait_time = 1
			b.damage += 80
