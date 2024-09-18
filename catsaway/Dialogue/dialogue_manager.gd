extends Node

@onready var dialogue_script : Array[String] = []
@onready var dialogue_pointer : int = 0
var dialogue_script_size : int

const tutorial_start_dialogue : Array[String] = [
	"Hello! Welcome to the Cataways tutorial",
	"This game revolves around expanding your land and building your catraptions in order to best the enemies",
	"To start press on the hammer icon on the bottom left, then click on the highlighted tile"
]

const placed_tile_dialogue : Array[String] = [
	"Nice! Doing this expands your land and allows more room for you and your catraptions.",
	"Note that placing tiles cost gold, which is indicated by the hammer on the upper left, so be cautious! Place arrows pointing towards it maybe",
	"Now, try placing a catraption down. Click on the dropped catraption and click on your newly made tiles."
]

const place_catraption_dialogue : Array[String] = [
	"Good job! Your land is now protected from incoming enemies.",
	"Catraptions fend away enemies by shooting at them, attacking differently depending on the catraption type",
	"Watch as your catraption fends away an enemy"
]

const upgrade_tutorial_dialogue : Array[String] = [
	"You are nearing the end of the tutorial! Your catraptions are also able to upgrade once you receive a duplicate",
	"Test this out by placing another catraption in the highlighted tile"
]

const grid_tutorial_dialogue : Array[String] = [
	"You have just placed a catraption inside the catraptions upgrade pattern",
	"Catraptions can only be upgraded when placed in specific positions",
	"Catraptions also require another copy of itself to be upgraded",
	"You now meet the requirements to upgrade the yarn thrower, click on the blue upgrade button on the bottom right, then click on the catraption you want to upgrade."
]

const sacrifice_dialogue : Array[String] = [
	"Finally, click on the yarn thrower you would like to sacrifice."
]

const congratulations_dialogue : Array[String] = [
	"Congratulation! You have completed the tutorial.",
	"You will now start the game in about 5 seconds, feel free to use the wrench to delete all the tiles you have placed."
]
