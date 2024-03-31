extends RayCast3D
class_name SightInteractorComponent

var interactor:SituationAwarenessComponent

signal play_audio(audio:AudioStream)
signal interact_changed(can_interact:bool)

func _ready():
	pass # Replace with function body.

func _process(delta):
	# do some action when trying to interact with an interactor
	if interactor != null and Input.is_action_just_pressed('interact'):
		play_audio.emit(interactor.answers_to)
		interactor.listen_to_call(self.global_position)

func _physics_process(delta):
	if is_colliding():
		# stop here if the interactor has already been set from this collision
		if interactor != null:
			return
		
		# go through all components, stop if interactor is found
		for child in get_collider().get_children():
			if child is SituationAwarenessComponent:
				if interactor != child:
					interactor = child
					interact_changed.emit(true)
				break
		# no interactor found, skip next time the ray collides with this object
		if interactor == null:
			add_exception(get_collider())
	# transition from collision with an interactor
	elif interactor != null:
		# reset interactor and emit
		interactor = null
		interact_changed.emit(false)
