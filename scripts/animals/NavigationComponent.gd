extends Node3D
class_name NavigationComponent

var nav_agent: NavigationAgent3D
var movement_speed: float = 2.0

signal target_reached
signal set_target(target:Vector3)
signal current_direction(direction:Vector3)

func _ready():
	for child in get_children():
		if child is NavigationAgent3D:
			nav_agent = child
			break
	
	assert(nav_agent != null, "A NavigationAgent3D is required as child node")

func set_random_target():
	var radius = 15
	var random_position = Vector3(
		global_position.x + randf_range(-radius, radius),
		0,
		global_position.z + randf_range(-radius, radius)
	)
	nav_agent.set_target_position(random_position)
	
	# emit set_target signal to other components
	set_target.emit(random_position)

func _physics_process(_delta):
	# ignore any targets equal to Vector3.ZERO
	# to be able to clear out the target
	if nav_agent.target_position != Vector3.ZERO:
		# when target has been reached
		if nav_agent.is_navigation_finished():
			# clear out the target and emit target_reached to other components
			nav_agent.set_target_position(Vector3.ZERO)
			current_direction.emit(nav_agent.target_position)
			target_reached.emit()
			return
		
		# set current direction and emit signal to other components
		var direction := global_position.direction_to(nav_agent.get_next_path_position())
		current_direction.emit(direction)


func _on_state_component_state_changed(state):
	if state != 'moving' and nav_agent.target_position != Vector3.ZERO:
		# clear out the target and emit to other components
		nav_agent.set_target_position(Vector3.ZERO)
		current_direction.emit(nav_agent.target_position)
