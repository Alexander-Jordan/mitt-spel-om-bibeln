extends RigidBody3D
class_name FruitComponent

func _on_interaction_responder_component_execute_objectives(_objectives):
	# NOTE!
	# normally, we would act upon the objectives.
	# but since all fruits are ever only interacted with by eating them,
	# we interpret this simply as the fruit being eaten every time.
	# if this is changed in the future, then we need to adjust here.
	
	# when we are eaten, set the parent to invisible
	self.visible = false
	self.process_mode = Node.PROCESS_MODE_DISABLED
