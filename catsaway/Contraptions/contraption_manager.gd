extends Node

# no need for tiles here, tiles got that
# if i want to merge, check if for the keys w the tiles around it to see if available for merge, since it also
# takes care of proving the contraption name
var contraption_dic : Dictionary = {
	"BaseContraption": "res://Contraptions/contraption_base.tscn",
}

func create_contraption(name: String) -> Contraption:
	return load(contraption_dic.get(name)).instantiate()
