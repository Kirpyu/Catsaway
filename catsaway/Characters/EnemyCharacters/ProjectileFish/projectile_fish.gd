extends BaseEnemy

func _ready() -> void:
	super._ready()
	animated_sprite.play("moving")

func update_hp():
	if hp <= 0:
		speed = 0
		animated_sprite.visible = false
		death_sprite.visible = true
		death_sprite.play("death")
		
	hp_bar.value = hp
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.owner.has_method("hit") and area.owner.is_in_group("Tile"):
		stopped = true
		stop_timer.start()
		animated_sprite.play("attacking")
		velocity = Vector2(0,0)
		area.owner.hit(attack)
			
		hitbox_collision.set_deferred("disabled", true)
		
func _on_stop_timer_timeout() -> void:
	stopped = false
	hitbox_collision.set_deferred("disabled", false)
	animated_sprite.play("moving")
	
func _process(delta: float) -> void:
	if target == null:
		get_closest_target()
	elif !stopped:
		var direction = target.global_position - self.global_position
		velocity = direction.normalized() * speed 
		move_and_slide()
		look_at(target.global_position)
		if direction.length() < 50:
			shoot()

var projectile = preload("res://Projectiles/AcidBall/acid_ball.tscn")
func shoot():
	stopped = true
	stop_timer.start()
	animated_sprite.play("attacking")
	velocity = Vector2(0,0)
	hitbox_collision.set_deferred("disabled", true)
	get_closest_target()
	
	var b = projectile.instantiate()
	get_tree().root.add_child(b)
	b.transform = $Marker2D.global_transform
