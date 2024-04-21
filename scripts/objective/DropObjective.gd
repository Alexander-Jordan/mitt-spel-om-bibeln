extends Objective
class_name DropObjective

var drop_component:DropComponent

# search for the required components using the list of nodes provided
# if all required components are found: set them and return true
# otherwise: return false
func try_to_set_required_components(nodes_to_search: Array[Node]) -> bool:
	for child in nodes_to_search:
		if child is DropComponent:
			drop_component = child
			return true
	return false

# execute the objective
func execute():
	drop_component.drop()
	done.emit()
