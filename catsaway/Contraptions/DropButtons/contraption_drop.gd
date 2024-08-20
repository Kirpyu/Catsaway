class_name Drop extends Button

@export var drop_name : String = "FeatherToy"

func _ready() -> void:
	icon = load(ContraptionManager.contraption_dic[drop_name]["Icon"])
	%DropSound.play()
	
	
func _on_pressed() -> void:
	%ReelSound.play()
	var contraption_node = get_tree().get_first_node_in_group("ContraptionNode")
	contraption_node.handle_drop(self)
	

func _on_timer_timeout() -> void:
	queue_free()
