extends Projectile

@export var attacking_sprite : AnimatedSprite2D
@export var end_sprite : AnimatedSprite2D
@export var laser_time : Timer
@export var laser_tick : Timer
@export var hitbox : CollisionShape2D

func _ready() -> void:
	sprite.play("startup")

func _on_area_entered(area: Area2D) -> void:
	if area == null:
		return

	if area.owner.has_method("hit") and area.owner.is_in_group("Enemy"):
		area.owner.hit(damage)

func _on_animated_sprite_2d_animation_finished() -> void:
	print("second step started")
	attacking_sprite.visible = true
	sprite.visible = false
	laser_time.start()
	laser_tick.start()
	attacking_sprite.play("shooting")

func _on_laser_tick_timeout() -> void:
	if hitbox.disabled == true:
		hitbox.set_deferred("disabled", false)
	else:
		hitbox.set_deferred("disabled", true)

func _on_laser_time_timeout() -> void:
	laser_tick.stop()
	attacking_sprite.visible = false
	end_sprite.visible = true
	end_sprite.play("end")


func _on_end_sprite_animation_finished() -> void:
	queue_free()
