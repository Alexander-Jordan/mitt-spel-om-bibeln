extends RayCast3D
class_name SightInteractorComponent

var collider:Object = null
var interactor:SituationAwarenessComponent

signal play_audio(audio:AudioStream)
signal interact_changed(can_interact:bool)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if collider != null and collider is CharacterBody3D and interactor == null:
		for child in collider.get_children():
			if child is SituationAwarenessComponent:
				if interactor != child:
					interactor = child
					interact_changed.emit(true)
				break
	
	if interactor != null and Input.is_action_just_pressed('interact'):
		play_audio.emit(interactor.answers_to)
		interactor.listen_to_call(self.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_colliding() and collider != null:
		collider = null
		interactor = null
		interact_changed.emit(false)
	if is_colliding():
		collider = get_collider()
