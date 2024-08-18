extends Contraption

@export var middle : Marker2D
@export var feather_toy_resource : ProjectileResource

func _physics_process(delta: float) -> void:
	middle.rotation_degrees += delta * 200

func _on_stick_hitbox_area_entered(area: Area2D) -> void:
	if area.owner.has_method("hit") and area.owner.is_in_group("Enemy"):
		area.owner.hit(feather_toy_resource.damage) 


func _on_head_hitbox_area_entered(area: Area2D) -> void:
	if area.owner.has_method("hit") and area.owner.is_in_group("Enemy"):
		area.owner.hit(feather_toy_resource.damage/5)

func _process(_delta: float) -> void:
	pass

func get_closest_target():
	pass

func shoot():
	pass


func _on_shoot_cooldown_timeout() -> void:
	pass
