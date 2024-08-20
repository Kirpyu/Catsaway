extends Control

@onready var page_num = 0
@onready var pages = [%Page1, %Page2, %Page3, %Page4, %Page5]


func _on_left_pressed() -> void:
	if page_num <= 0:
		pass
	else:
		pages[page_num].hide()
		page_num -= 1
		pages[page_num].show()


func _on_right_pressed() -> void:
	if page_num >= 4:
		pass
	else:
		pages[page_num].hide()
		page_num += 1
		pages[page_num].show()
		
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://GUI/main_menu.tscn")
