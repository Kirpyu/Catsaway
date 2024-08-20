extends Contraption

func _ready() -> void:
	projectile = load("res://Projectiles/Laser/laser.tscn")

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
	spawn_point.add_child(b)
	b.global_position = spawn_point.global_position
	
	match TileManager.Land[contraption_tile]["Level"]:
			1:
				shoot_cd.wait_time = 2.5
				b.damage += 10
				b.scale = Vector2(1.2,1)
			2:
				shoot_cd.wait_time = 2.5
				b.damage += 15
				b.scale = Vector2(1.2,1)
			3:
				shoot_cd.wait_time = 2
				b.damage += 20
				b.scale = Vector2(1.4,1)
			4:
				shoot_cd.wait_time = 1.5
				b.damage += 25
				b.scale = Vector2(1.6,1)
			5:
				shoot_cd.wait_time = 1
				b.damage += 30
				b.scale = Vector2(2,1)
