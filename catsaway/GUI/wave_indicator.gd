extends Label

var wave_count = 1
func _ready() -> void:
	text = "Wave: " + str(wave_count)
	
func _on_timer_timeout() -> void:
	wave_count += 1
	text = "Wave:" + str(wave_count)
