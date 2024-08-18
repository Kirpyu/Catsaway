extends Node

# no need for tiles here, tiles got that
# if i want to merge, check if for the keys w the tiles around it to see if available for merge, since it also
# takes care of proving the contraption name
var contraption_dic : Dictionary = {
	"BaseContraption": {
		"Script": "res://Contraptions/contraption_base.tscn",
		"Drop": "None"
	},
	
	"YarnThrower" : {
		"Script": "res://Contraptions/YarnThrower/yarn_thrower.tscn",
		"Drop": "None"
	},
	
	"CheeseCannon": {
		"Script": "res://Contraptions/CheeseCannon/cheese_cannon.tscn"
	},
	
	"Pawsplosion": {
		"Script": "res://Contraptions/Pawsplosion/pawsplosion.tscn"
	},
	
	"LaserToy": {
		"Script": "res://Contraptions/LaserToy/laser_toy.tscn"
	},
	
	"FeatherToy": {
		"Script": "res://Contraptions/FeatherToy/feather_toy.tscn"
	},
}

func create_contraption(contraption_name: String) -> Contraption:
	return load(contraption_dic.get(contraption_name)["Script"]).instantiate()
