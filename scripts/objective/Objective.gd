extends Resource
class_name Objective

signal done
signal start_time(time: float)

# search for the required components using the list of nodes provided
# if all required components are found: set them and return true
# otherwise: return false
func try_to_set_required_components(_nodes_to_search: Array[Node]) -> bool:
	return true

# execute the objective
func execute():
	pass

func start_random_time_from_range(min_time: int = 0, max_time: int = 0):
	if max_time <= 0 and min_time <= 0:
		start_time.emit(0)
		return
	
	if max_time <= 0 or max_time <= min_time:
		start_time.emit(min_time)
		return
	
	if min_time <= 0 or min_time >= max_time:
		start_time.emit(randf_range(0, max_time))
		return
	
	start_time.emit(randf_range(min_time, max_time))

func _on_objective_done():
	done.emit()
