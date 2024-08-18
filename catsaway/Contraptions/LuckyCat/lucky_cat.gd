extends Contraption

func _ready() -> void:
	animated_sprite.play("default")
	
func _process(_delta: float) -> void:
	pass

func get_closest_target():
	pass

func shoot():
	get_closest_target()
	var b = projectile.instantiate()
	get_tree().root.add_child(b)
	b.transform = spawn_point.global_transform
#	print money
