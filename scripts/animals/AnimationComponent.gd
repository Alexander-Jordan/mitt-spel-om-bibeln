extends AnimationTree
class_name AnimationComponent

func _on_state_component_state_changed(state: String):
	if (state == 'idle'):
		set("parameters/conditions/idle", true)
		set("parameters/conditions/is_moving", false)
	if (state == 'moving'):
		set("parameters/conditions/idle", false)
		set("parameters/conditions/is_moving", true)
