extends RayCast3D
class_name InteractionInitiatorRaySensorComponent

@export var initiator:InteractionInitiatorComponent

func _physics_process(delta):
	# don't do anything without an initiator
	if initiator == null:
		return
	
	if is_colliding():
		# stop here if the interactor has already been set from this collision
		if initiator.responder != null:
			return
		
		# go through all components, stop if responder is found
		for child in get_collider().get_children():
			if child is InteractionResponderComponent:
				initiator.set_responder(child)
				break
		# no responder found, skip next time the ray collides with this object
		if initiator.responder == null:
			add_exception_rid(get_collider_rid())
	# transition from collision with an responder
	elif initiator.responder != null:
		# reset responder and emit
		initiator.set_responder(null)
