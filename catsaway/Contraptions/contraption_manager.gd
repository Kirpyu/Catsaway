extends Node

# no need for tiles here, tiles got that
# if i want to merge, check if for the keys w the tiles around it to see if available for merge, since it also
# takes care of proving the contraption name
var contraption_dic : Dictionary = {
	#"BaseContraption": {
		#"Script": "res://Contraptions/contraption_base.tscn",
		#"Icon": "None"
	#},
	#
	"YarnThrower" : {
		"Script": "res://Contraptions/YarnThrower/yarn_thrower.tscn",
		"Icon": "res://Assets/ContraptionAssets/YarnThrower/Yarn_Thrower-Icon.png",
		"Pattern": [Vector2i(0, -1), Vector2(-1, 0), Vector2i(1,0), Vector2i(0,1)],
		"Sacrifice": "res://Contraptions/YarnThrower/sacrificial_yarn_thrower.tscn",
	},
	
	"CheeseCannon": {
		"Script": "res://Contraptions/CheeseCannon/cheese_cannon.tscn",
		"Icon": "res://Assets/ContraptionAssets/CheeseCannon/cannon-icon.png",
		"Pattern": [Vector2i(0, -1), Vector2(2, -1), Vector2i(1,0), Vector2i(1,-2)],
		"Sacrifice": "res://Contraptions/CheeseCannon/sacrificial_cheese_cannon.tscn",
	},
	
	"Pawsplosion": {
		"Script": "res://Contraptions/Pawsplosion/pawsplosion.tscn",
		"Icon": "res://Assets/ContraptionAssets/Pawsplosion/catTree-icon.png",
		"Pattern": [Vector2i(-1, 0), Vector2(0, -1), Vector2i(1,-1), Vector2i(-1,1)],
		"Sacrifice": "res://Contraptions/Pawsplosion/sacrificial_pawsplosion.tscn",
	},
	
	"LaserToy": {
		"Script": "res://Contraptions/LaserToy/laser_toy.tscn",
		"Icon": "res://Assets/ContraptionAssets/LaserToy/LaserPointer-Icon.png",
		"Pattern": [Vector2i(0, -2), Vector2(-1, -2), Vector2i(-2,-1), Vector2i(-2,0)],
		"Sacrifice": "res://Contraptions/LaserToy/sacrificial_laser_toy.tscn",
	},
	
	"FeatherToy": {
		"Script": "res://Contraptions/FeatherToy/feather_toy.tscn",
		"Icon": "res://Assets/ContraptionAssets/FeatherToy/StandFeatherToy.png",
		"Pattern": [Vector2i(2, 0), Vector2(1, 0), Vector2i(0,1), Vector2i(0,2)],
		"Sacrifice": "res://Contraptions/FeatherToy/sacrificial_feather_toy.tscn",
	},
	
	"LuckyCat": {
		"Script": "res://Contraptions/LuckyCat/lucky_cat.tscn",
		"Icon": "res://Assets/ContraptionAssets/LuckyCat/moneyMaker-Icon.png",
		"Pattern": [Vector2i(-1, 0), Vector2(1, 0), Vector2i(-1,1), Vector2i(1,1)],
		"Sacrifice": "res://Contraptions/LuckyCat/sacrificial_lucky_cat.tscn",
	},
}

func create_contraption(contraption_name: String) -> Contraption:
	return load(contraption_dic.get(contraption_name)["Script"]).instantiate()

func create_sacrifice(contraption_name: String) -> Contraption:
	return load(contraption_dic.get(contraption_name)["Sacrifice"]).instantiate()
