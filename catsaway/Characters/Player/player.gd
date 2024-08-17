extends CharacterBody2D

var direction :Vector2 = Vector2.ZERO
@export var movespeed := 50

var tiles_created := {}

func _physics_process(_delta):
	direction = Input.get_vector("left","right","up","down").normalized()
	set_velocity(direction * movespeed)
	move_and_slide()
	direction = velocity
