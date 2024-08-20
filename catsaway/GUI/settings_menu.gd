extends Control

var _is_paused:bool = false:
	set = set_paused

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_is_paused = !_is_paused
		
func set_paused(value:bool) -> void:
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused
	
func resume_game():
	_is_paused = false

func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://GUI/main_menu.tscn")


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://GameScene/main_scene.tscn")


func _on_resume_button_pressed() -> void:
	resume_game()
