extends Contraption

func _ready() -> void:
	projectile = load("res://Projectiles/Paw/paw.tscn")
	animated_sprite.play("idle")
	

func _process(_delta: float) -> void:
	if closest_enemy != null:
		if shoot_cd.is_stopped():
			shoot_cd.start()
	else: 
		shoot_cd.stop()
		get_closest_target()

func shoot():
	get_closest_target()
	var direction = closest_enemy.global_position - self.global_position
	if direction.length() < 90:
		var b = projectile.instantiate()
		get_tree().root.add_child(b)
		b.transform = closest_enemy.global_transform
		b.rotation_degrees -= 180
	
		match TileManager.Land[contraption_tile]["Level"]:
			2:
				shoot_cd.wait_time = 1.625
				b.damage += 35
				b.scale = Vector2(1.2,1.2)
			3:
				shoot_cd.wait_time = 1.25
				b.damage += 70
				b.scale = Vector2(1.4,1.4)
			4:
				shoot_cd.wait_time = 0.875
				b.damage += 105
				b.scale = Vector2(1.6,1.6)
			5:
				shoot_cd.wait_time = 0.5
				b.damage += 140
				b.scale = Vector2(2,2)
	
