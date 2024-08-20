extends Contraption

func _ready() -> void:
	shoot_cd.stop()
	
func _process(_delta: float) -> void:
	pass

func get_closest_target():
	pass

func shoot():
	pass


func _on_shoot_cooldown_timeout() -> void:
	pass
