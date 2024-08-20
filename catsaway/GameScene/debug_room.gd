class_name Debugger extends Node2D

@export var player : CharacterBody2D

func _ready() -> void:
	player.gold += 10000000
