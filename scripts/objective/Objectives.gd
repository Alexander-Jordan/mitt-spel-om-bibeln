extends Resource
class_name Objectives

var queue: Array[Objective]
var current: Objective
var previous: Objective

# add objective to the queue, defaults to the back
func add_to_queue(objective: Objective, front: bool = false) -> void:
	# setup connection to run next in queue when objective is done
	objective.done.connect(next_in_queue)
	# add to the front or end of queue
	if front == true:
		queue.push_front(objective)
	else:
		queue.append(objective)

# execute the next objective in queue
func next_in_queue() -> void:
	# keep track of previous objective before switching
	previous = current
	# next in line will be current
	# if the queue is empty then current is set to null
	current = queue.pop_front()
	# execute current objective if not null
	if current != null:
		current.execute()
