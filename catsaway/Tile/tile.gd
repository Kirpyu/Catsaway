class_name Tile
extends Node2D

@export var max_hp := 100
@export var hp_bar : ProgressBar
@export var self_heal_timer: Timer
@export var self_heal_cd: Timer

var hp : int
var tile_name : String = ""
var water_tile : bool = true
var enemy_attacking := false

func _ready() -> void:
	hp = max_hp
	hp_bar.max_value = max_hp
	update_hp()

#take damage
# record damage and recepient
# if still not empty, keep taking damage
# removes recipient if u leave or die
func hit(damage: int) -> void:
	hp -= damage
	hp_bar.show()
	self_heal_cd.start()
	update_hp()
	%TileAttackedSFX.play()
	
func update_hp() -> void:
	if hp <= 0:
		var ground_layer = get_tree().get_first_node_in_group("GroundLayer")
		ground_layer.erase_tile(TileManager.string_to_vector2(tile_name))
		var contraption_script = get_tree().get_first_node_in_group("ContraptionNode")
		contraption_script.erase_contraption(tile_name)
		%Area2D.set_deferred("disabled", true)
		if %TileSinkSFX.playing == false:
			%TileSinkSFX.play()
	else:
		hp_bar.value = hp
		if hp >= 100:
			hp_bar.hide()
	
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner.has_method("hit") and area.owner.is_in_group("Enemy") and water_tile == true:
		pass
#		reroll\
	if area.owner.is_in_group("Player") and water_tile == true:
		get_tree().quit()


func _on_self_heal_timeout() -> void:
	if hp + 10 > max_hp:
		hp = max_hp
		self_heal_timer.stop()
		hp_bar.hide()
	else:
		hp += 10
		update_hp()



func _on_self_heal_cooldown_timeout() -> void:
	self_heal_timer.start()


func _on_tile_sink_sfx_finished() -> void:
	queue_free()
