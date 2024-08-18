class_name Drop extends Button

var drop_name : String = "BaseContraption"
func _on_pressed() -> void:
	var contraption_node = get_tree().get_first_node_in_group("ContraptionNode")
	contraption_node.handle_drop(self)

func _on_timer_timeout() -> void:
	queue_free()
