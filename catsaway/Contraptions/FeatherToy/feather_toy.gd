extends Contraption

@export var damage : int
@export var middle : Marker2D
@export var feather_toy_resource : ProjectileResource

func _ready() -> void:
	damage = 30

func _physics_process(delta: float) -> void:
	if TileManager.Land.has(contraption_tile):
		match TileManager.Land[contraption_tile]["Level"]:
				1:
					middle.rotation_degrees += delta * 200
					self.scale = Vector2(1,1)
					damage = 30
					
				2:
					middle.rotation_degrees += delta * 400
					self.scale = Vector2(1.1,1.1)
					damage = 40
				3:
					middle.rotation_degrees += delta * 600
					self.scale = Vector2(1.2,1.2)
					damage = 50
				4:
					middle.rotation_degrees += delta * 800
					self.scale = Vector2(1.3,1.3)
					damage = 60
				5:
					middle.rotation_degrees += delta * 1000
					self.scale = Vector2(1.4,1.4)
					damage = 80
	

func _on_stick_hitbox_area_entered(area: Area2D) -> void:
	if area.owner.has_method("hit") and area.owner.is_in_group("Enemy"):
		area.owner.hit(damage) 


func _on_head_hitbox_area_entered(area: Area2D) -> void:
	if area.owner.has_method("hit") and area.owner.is_in_group("Enemy"):
		area.owner.hit(damage/5)

func _process(_delta: float) -> void:
	pass

func get_closest_target():
	pass

func shoot():
	pass


func _on_shoot_cooldown_timeout() -> void:
	pass
