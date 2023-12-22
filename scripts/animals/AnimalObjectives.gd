extends Node3D
class_name AnimalObjectives

@export var pickable_objectives: Array[Objective]

var objectives: Objectives = Objectives.new()
var timer: Timer

func _ready():
	for child in get_children():
		if child is Timer:
			timer = child
			break
	assert(timer != null, "A Timer node is required as a child node")
	
	# if the timer runs out: execute the next objective
	timer.timeout.connect(func(): objectives.next_in_queue())
	
	# add 5 objectives to the queue
	for _i in 5:
		add_random_objective()
	# execute the first objective in queue
	objectives.next_in_queue()

func _process(_delta):
	# continue to add objectives to the queue when lower than 5
	if objectives.queue.size() < 5:
		add_random_objective()

# setup and add objective to the queue
func add_objective(objective: Objective):
	if objective.try_to_set_required_components(get_children()):
		objective.start_time.connect(_on_objective_start_time)
		objectives.add_to_queue(objective)

# add a random objective from pickable objectives
func add_random_objective():
	if not pickable_objectives.is_empty():
		add_objective(
			pickable_objectives[
				randi_range(0, pickable_objectives.size() - 1)
			].duplicate(true)
		)

func _on_objective_start_time(time: float = 0):
	timer.start(time)
