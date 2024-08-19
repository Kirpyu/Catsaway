extends BaseEnemy

func _ready() -> void:
	fish_name = "NormalFish"
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
		area.owner.hit(enemy_resource.attack)
			
		hitbox_collision.set_deferred("disabled", true)
		
func _on_stop_timer_timeout() -> void:
	stopped = false
	hitbox_collision.set_deferred("disabled", false)
	animated_sprite.play("moving")
