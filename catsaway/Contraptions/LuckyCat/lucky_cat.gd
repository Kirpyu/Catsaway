extends Contraption

@export var resource : ProjectileResource
var floating_text = load("res://Characters/floating_text.tscn")

func _ready() -> void:
	animated_sprite.play("default")
	
func _process(_delta: float) -> void:
	pass

func get_closest_target():
	pass

func shoot():
	var player = get_tree().get_first_node_in_group("Player")
	player.gold += 10 * (resource.level + 1)
#	print money
