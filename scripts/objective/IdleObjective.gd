extends Objective
class_name IdleObjective

@export var min_time: int = 1
@export var max_time: int = 10

var state_component: StateComponent
var state: String = 'idle'

# search for the required components using the list of nodes provided
# if all required components are found: set them and return true
# otherwise: return false
func try_to_set_required_components(nodes_to_search: Array[Node]) -> bool:
	for child in nodes_to_search:
		if child is StateComponent:
			state_component = child
			return true
	return false

# execute the objective
func execute():
	state_component.set_state(self.state)
	start_random_time_from_range(self.min_time, self.max_time)
