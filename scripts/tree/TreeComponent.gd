extends Node3D
class_name TreeComponent

var objectives: Objectives = Objectives.new()
var timer: Timer
var min_time: float = 1
var max_time: float = 60

signal drop_item(position:Vector3)

func _ready():
	for child in get_children():
		if child is Timer:
			timer = child
			break
	assert(timer != null, "A Timer node is required as a child node")
	
	# if the timer runs out: execute the next objective
	timer.timeout.connect(timeout)
	# begin by running the timeout function
	timeout()

func timeout():
	start_random_time()
	try_to_add_drop_objective()

func start_random_time():
	var min_time: float = 1
	var max_time: float = 60
	timer.start(randf_range(min_time, max_time))

func try_to_add_drop_objective():
	# 10% chance of addding a new drop objective
	if randi_range(1, 1) == 1:
		var drop_objective:DropObjective = DropObjective.new()
		# trigger start_random_time function when objective is done
		drop_objective.done.connect(start_random_time)
		# check if it can be added
		if drop_objective.try_to_set_required_components(get_children()):
			objectives.add_to_queue(drop_objective)
			# run objective immediately
			objectives.next_in_queue()
			

func _on_interaction_responder_component_execute_objectives(execute_objectives):
	for objective in execute_objectives:
		# trigger start_random_time function when objective is done
		objective.done.connect(start_random_time)
		# check if it can be added
		if objective.try_to_set_required_components(get_children()):
			objectives.add_to_queue(objective)
	# execute next objective in queue
	objectives.next_in_queue()


func _on_drop_component_drop_item(position:Vector3):
	drop_item.emit(position)
