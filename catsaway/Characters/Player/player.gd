extends CharacterBody2D

var direction :Vector2 = Vector2.ZERO
@export var movespeed := 50
@export var animated_sprite : AnimatedSprite2D

func _physics_process(_delta):
	direction = Input.get_vector("left","right","up","down").normalized()
	set_velocity(direction * movespeed)
	move_and_slide()
	direction = velocity
	
	if velocity == Vector2.ZERO:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walking")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("right"):
		animated_sprite.flip_h = true
	
	if Input.is_action_just_pressed("left"):
		animated_sprite.flip_h = false
		

#make the player lose when they touch the water

func place_contraption():
	pass
