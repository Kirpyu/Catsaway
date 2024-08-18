class_name Projectile extends Area2D

@export var projectile_resource : ProjectileResource
@export var sprite : AnimatedSprite2D

var collat : int
@onready var speed : int = 1

func _ready() -> void:
	collat = projectile_resource.collat
	sprite.play("default")

func _physics_process(delta):
	position += transform.x * projectile_resource.speed * delta * speed
	
#can write something like + Buffs.damage if i implement more things in the future
func _on_area_entered(area: Area2D) -> void:
	if area == null:
		return

	if area.owner.has_method("hit") and area.owner.is_in_group("Enemy"):
		
		collat -= 1
		area.owner.hit(projectile_resource.damage) 
		if collat == 0:
			queue_free()
	
	if area.owner.has_method("hit") and area.owner.is_in_group("Tile"):
		
		collat -= 1
		area.owner.hit(projectile_resource.damage) 
		if collat == 0:
			queue_free()
	
func _on_despawn_timer_timeout() -> void:
	queue_free()
