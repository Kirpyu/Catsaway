extends Projectile

func _on_area_entered(area: Area2D) -> void:
	if area == null:
		return

	if area.owner.has_method("hit") and area.owner.is_in_group("Enemy"):
		
		collat -= 1
		area.owner.hit(damage) 
		%YarnSFX.play()
		if collat == 0:
			queue_free()
