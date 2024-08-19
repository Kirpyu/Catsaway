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
		"Icon": "res://Assets/ContraptionAssets/YarnThrower/Yarn_Thrower-Icon.png"
	},
	
	"CheeseCannon": {
		"Script": "res://Contraptions/CheeseCannon/cheese_cannon.tscn",
		"Icon": "res://Assets/ContraptionAssets/CheeseCannon/cannon-icon.png"
	},
	
	"Pawsplosion": {
		"Script": "res://Contraptions/Pawsplosion/pawsplosion.tscn",
		"Icon": "res://Assets/ContraptionAssets/Pawsplosion/catTree-icon.png"
	},
	
	"LaserToy": {
		"Script": "res://Contraptions/LaserToy/laser_toy.tscn",
		"Icon": "res://Assets/ContraptionAssets/LaserToy/LaserPointer-Icon.png"
	},
	
	"FeatherToy": {
		"Script": "res://Contraptions/FeatherToy/feather_toy.tscn",
		"Icon": "res://Assets/ContraptionAssets/FeatherToy/StandFeatherToy.png"
	},
	
	"LuckyCat": {
		"Script": "res://Contraptions/LuckyCat/lucky_cat.tscn",
		"Icon": "res://Assets/ContraptionAssets/LuckyCat/moneyMaker-Icon.png"
	},
}

func create_contraption(contraption_name: String) -> Contraption:
	return load(contraption_dic.get(contraption_name)["Script"]).instantiate()
