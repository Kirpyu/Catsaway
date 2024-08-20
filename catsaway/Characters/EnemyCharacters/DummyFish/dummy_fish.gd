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

func update_hp():
	pass

func get_closest_target():
	pass
			
func _process(_delta: float) -> void:
	pass


func _on_hitbox_area_entered(_area: Area2D) -> void:
	pass
	


func _on_stop_timer_timeout() -> void:
	pass
#	drop a button which queues free after 10 secs. on button click, gain a building in inventory

func create_drop():
	pass

func drop_gold():
	var player = get_tree().get_first_node_in_group("Player")
	player.gold += enemy_resource.gold_given

func _on_death_sprite_2d_animation_finished() -> void:
	create_drop()
	drop_gold()
	queue_free()
