extends Objective
class_name LoseObjective

var character_body_3d:CharacterBody3D

# search for the required components using the list of nodes provided
# if all required components are found: set them and return true
# otherwise: return false
func try_to_set_required_components(nodes_to_search: Array[Node]) -> bool:
	for child in nodes_to_search:
		if child is CharacterBody3D:
			character_body_3d = child
	# check if all required components are set
	return null not in [character_body_3d]
