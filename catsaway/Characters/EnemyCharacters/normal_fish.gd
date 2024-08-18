extends BaseEnemy

var dead = false

func _ready() -> void:
	super._ready()
	animated_sprite.play("moving")

func update_hp():
	if hp <= 0:
		drop_upgrade()
		dead = true
		animated_sprite.play("death")
		
	hp_bar.value = hp
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.owner.has_method("hit") and area.owner.is_in_group("Tile") and !dead:
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


func _on_animated_sprite_2d_animation_finished() -> void:
	var drop = load("res://Contraptions/DropButtons/contraption_drop.tscn").instantiate()
	get_tree().root.add_child(drop)
	drop.position = self.global_position
	
	queue_free()
