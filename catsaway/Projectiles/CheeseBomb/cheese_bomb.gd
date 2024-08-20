extends Projectile

@export var hitbox_col : CollisionShape2D
@export var explosion_sprite : AnimatedSprite2D

func _on_explosion_sprite_animation_finished() -> void:
	queue_free()
	
func _ready() -> void:
	collat = projectile_resource.collat
	%CheeseThrow.play()
	
func _process(delta: float) -> void:
	sprite.rotation_degrees += delta * 1000
	
func _on_area_entered(area: Area2D) -> void:
	if area == null:
		return

	if area.owner.has_method("hit") and area.owner.is_in_group("Enemy"):
		
		collat -= 1
		area.owner.hit(projectile_resource.damage) 
		%CheeseExplosion.play()
		if collat <= 0:
			hitbox_col.set_deferred("disabled", false)
			explosion_sprite.visible = true
			sprite.visible = false
			speed = 0
			explosion_sprite.play("explode")


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.owner.has_method("hit") and area.owner.is_in_group("Enemy"):
		area.owner.hit(projectile_resource.damage) 
