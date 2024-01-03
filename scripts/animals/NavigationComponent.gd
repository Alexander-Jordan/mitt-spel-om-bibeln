extends Node3D
class_name NavigationComponent

var nav_agent: NavigationAgent3D
var movement_speed: float = 2.0
var target: Variant = null : set = set_target

signal target_reached
signal target_changed(target: Vector3)
signal next_path_position(next_path_position: Variant)

func _ready():
	for child in get_children():
		if child is NavigationAgent3D:
			nav_agent = child
			break
	
	assert(nav_agent != null, "A NavigationAgent3D is required as child node")

func _physics_process(_delta):
	# only update navigation when target is not null
	if target != null:
		# when target has been reached
		if nav_agent.is_navigation_finished():
			# clear out the target and emit target_reached to other components
			self.set_target(null)
			next_path_position.emit(target)
			target_reached.emit()
			return
		
		# emit next_path_position signal to other components
		next_path_position.emit(nav_agent.get_next_path_position())

func set_target(new_target: Variant):
	if not new_target is Vector3 and new_target != null:
		return
	
	# set the navigation agent target position, but only when Vector3
	if new_target is Vector3:
		nav_agent.set_target_position(new_target)
	
	# set the target variable
	target = new_target
	# emit target_changed signal to other components
	target_changed.emit(target)

func set_random_target():
	var radius = 15
	# set target to random position within range
	self.set_target(Vector3(
		global_position.x + randf_range(-radius, radius),
		0,
		global_position.z + randf_range(-radius, radius)
	))

func _on_state_component_state_changed(state):
	if state != 'moving' and target != null:
		# clear out the target and emit to other components
		target = null
		next_path_position.emit(target)
