class_name PopUpText extends Panel

@onready var label := %Label

#Test Script to check if panel is working
#func _ready() -> void:
	#setup_script(["Hello", "This is a test", "To check if it is working", "End"])

func setup_script(label_script: Array[String]):
	if label_script != []:
		DialogueManager.dialogue_script = label_script
		DialogueManager.dialogue_script_size = label_script.size()
		DialogueManager.dialogue_pointer = 0
		draw_popup(DialogueManager.dialogue_script[DialogueManager.dialogue_pointer])
		show()		

func draw_popup(text: String):
	%Label.text = text
	
func _on_button_pressed() -> void:
	DialogueManager.dialogue_pointer += 1
	if DialogueManager.dialogue_pointer < DialogueManager.dialogue_script_size:
		draw_popup(DialogueManager.dialogue_script[DialogueManager.dialogue_pointer])
	else:
#		clear script in the future
		hide()
	
