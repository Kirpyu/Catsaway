extends Control


func _on_resume_button_pressed() -> void:
	get_tree().change_scene_to_file("res://GameScene/main_scene.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://GUI/tutorial_menu.tscn")
