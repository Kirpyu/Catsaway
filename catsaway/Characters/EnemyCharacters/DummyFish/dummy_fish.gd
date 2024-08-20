extends BaseEnemy

func _ready() -> void:
	get_closest_target()
	hp_bar.max_value = enemy_resource.max_hp
	hp = enemy_resource.max_hp
	update_hp()
	animated_sprite.play("moving")
	
func hit(damage:int):
	hp -= damage;
	print(damage)
	update_hp()
