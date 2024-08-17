class_name Hitbox
extends Area2D
		
func _on_area_entered(area: Area2D) -> void:
	if area.owner.has_method("hit") and area.owner.is_in_group("Tile"):
			area.owner.hit(15)
