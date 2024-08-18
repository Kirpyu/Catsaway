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
