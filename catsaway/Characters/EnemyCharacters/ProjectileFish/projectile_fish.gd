extends BaseEnemy

func _ready() -> void:
	fish_name = "ProjectileFish"
	super._ready()
	animated_sprite.play("moving")
	
func reset() -> void:
	var new_resource = ProjectileFishResource.new()
	new_resource.reset()
	enemy_resource.max_hp = new_resource.max_hp
	enemy_resource.speed = new_resource.speed
	enemy_resource.attack = new_resource.attack
	enemy_resource.gold_given = new_resource.gold_given

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
		area.owner.hit(enemy_resource.attack)
			
		hitbox_collision.set_deferred("disabled", true)
		
func _on_stop_timer_timeout() -> void:
	stopped = false
	hitbox_collision.set_deferred("disabled", false)
	animated_sprite.play("moving")
	
func _process(_delta: float) -> void:
	if target == null:
		get_closest_target()
	elif !stopped:
		var direction = target.global_position - self.global_position
		velocity = direction.normalized() * enemy_resource.speed 
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
