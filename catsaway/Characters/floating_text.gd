extends Label
var rng = RandomNumberGenerator.new()
	
func show_value(value: String, color):
	text = value
	var tween : Tween = create_tween()
	tween.tween_property(self, "modulate", color, 0)
	tween.tween_property(self, "position", position + Vector2(rng.randf_range(-50,50),rng.randf_range(-50,-100)), .5).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(self.queue_free)
