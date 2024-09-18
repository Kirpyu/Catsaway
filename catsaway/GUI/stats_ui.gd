extends Control

@export var settings_menu : Control
@export var show_wave : bool

func _on_button_pressed() -> void:
	settings_menu.set_paused(true)

func _ready() -> void:
	if show_wave:
		%WaveGUI.show()
	else:
		%WaveGUI.hide()
