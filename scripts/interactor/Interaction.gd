extends Resource
class_name Interaction

@export var name:String = 'Interact'
@export var input_action_name:String = 'interact'
@export var initiator_audio:AudioStream
@export var responder_audio:AudioStream
@export var objectives:Array[Objective]
@export var max_distance:float = 20
var responder:InteractionResponderComponent = null

func is_available():
	pass

func input_listener(initiator:InteractionInitiatorComponent):
	if Input.is_action_just_pressed(input_action_name):
		execute_action(initiator)

func execute_action(initiator:InteractionInitiatorComponent):
	if responder == null:
		return
	
	if initiator_audio != null:
		initiator.play_audio.emit(initiator_audio)
	if responder_audio != null:
		responder.play_responder_audio.emit(responder_audio)
	if not objectives.is_empty():
		responder.execute_objectives.emit(objectives)
