extends RayCast3D
class_name PlayerSightComponent

# used to keep track of which object is currently being examined
var detected_object:Object = null : set = set_detected_object
func set_detected_object(object:Object):
	if object != detected_object:
		# reset every detected component to null when detected object change
		set_responder(null)
		# set detected object to new value
		detected_object = object

# components that's interesting for the player
# each should have a:
# - signal
# - variable
# - setter (which also triggers the signal)
signal responder_changed(responder:InteractionResponderComponent)
var responder:InteractionResponderComponent = null : set = set_responder
func set_responder(new_responder:InteractionResponderComponent):
	if new_responder != responder:
		responder = new_responder
		responder_changed.emit(responder)

func _physics_process(_delta):
	if is_colliding():
		# stop here if the current object has already been examined
		if detected_object == get_collider():
			return
		
		detected_object = get_collider()
		var interesting:bool = false
		
		# go through all components, stop if an interesting component is found
		for child in detected_object.get_children():
			if child is InteractionResponderComponent:
				interesting = true
				responder = child
				break
		
		# no interesting component found on this object
		# skip next time the ray collides with this object
		if !interesting:
			add_exception_rid(get_collider_rid())
	else:
		# reset everything to null when not detecting anything
		set_detected_object(null)
