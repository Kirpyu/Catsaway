extends BaseEnemy

func _ready() -> void:
	fish_name = "FlyingFish"
	super._ready()
	animated_sprite.play("moving")
	
func reset() -> void:
	var new_resource = FlyingFishResource.new()
	new_resource.reset()
	enemy_resource.max_hp = new_resource.max_hp
	enemy_resource.speed = new_resource.speed
	enemy_resource.attack = new_resource.attack
	enemy_resource.gold_given = new_resource.gold_given

func update_hp():
	if hp <= 0:
		create_drop()
		speed = 0
		animated_sprite.visible = false
		death_sprite.visible = true
		death_sprite.play("explode")

	hp_bar.value = hp
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.owner.has_method("hit") and area.owner.is_in_group("Tile"):
		stopped = true
		stop_timer.start()
		area.owner.hit(enemy_resource.attack)
		speed = 0
		animated_sprite.visible = false
		death_sprite.visible = true
		death_sprite.play("explode")

		
func _on_stop_timer_timeout() -> void:
	stopped = false
	hitbox_collision.set_deferred("disabled", false)
	animated_sprite.play("moving")
