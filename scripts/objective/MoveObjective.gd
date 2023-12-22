extends Objective
class_name MoveObjective

var state_component: StateComponent
var navigation_component: NavigationComponent
var state: String = 'moving'

# search for the required components using the list of nodes provided
# if all required components are found: set them and return true
# otherwise: return false
func try_to_set_required_components(nodes_to_search: Array[Node]) -> bool:
	for child in nodes_to_search:
		if child is StateComponent:
			state_component = child
		if child is NavigationComponent:
			navigation_component = child
	# check if all required components are set
	return null not in [state_component, navigation_component]

# execute the objective
func execute():
	navigation_component.set_random_target()
	navigation_component.target_reached.connect(_on_objective_done)
	state_component.set_state(self.state)
	start_random_time_from_range(1, 10)
