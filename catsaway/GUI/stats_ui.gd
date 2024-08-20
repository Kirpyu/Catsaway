extends Control

@export var settings_menu : Control

func _on_button_pressed() -> void:
	settings_menu.set_paused(true)
