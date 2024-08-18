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
	
	#if direction.length < 51:
	var b = projectile.instantiate()
	get_tree().root.add_child(b)
	b.transform = closest_enemy.global_transform
	b.rotation_degrees -= 180
