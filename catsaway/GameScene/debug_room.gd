class_name Debugger extends Node2D

@export var player : CharacterBody2D
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("g"):
		player.die()
