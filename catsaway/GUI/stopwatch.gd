extends Label
var time_elapsed : float = 0
var back_numbers : int = 0
var front_numbers : int = 0
var time_elapsed_int : int = 0

func _process(delta: float) -> void:
	time_elapsed += delta
	time_elapsed_int = int(time_elapsed)
	text = solve_for_front_num() + ":" + solve_for_back_num()

func solve_for_back_num() -> String:
	var seconds = time_elapsed_int % 60
	if seconds < 10:
		return "0" + str(seconds)
	
	return str(seconds)

func solve_for_front_num() -> String:
	var minutes = floor(time_elapsed_int / 60)
	if minutes < 10:
		return "0" + str(minutes)
	
	return str(minutes)
	
