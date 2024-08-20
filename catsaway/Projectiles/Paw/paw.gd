extends Projectile


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()

func _ready() -> void:
	super._ready()
	%PawSFX.play()
