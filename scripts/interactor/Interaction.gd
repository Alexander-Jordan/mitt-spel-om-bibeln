extends Resource
class_name Interaction

@export var name:String = 'Interact'
@export var input_action_name:String = 'interact'
@export var initiator_audio:AudioStream
@export var responder_audio:AudioStream
@export var objectives:Array[Objective]
@export var initiator_objectives:Array[Objective]
@export var min_distance:float = 0
@export var max_distance:float = 20

func pre_execution_setup(_responder:InteractionResponderComponent, _initiator:InteractionInitiatorComponent):
	pass

func is_available():
	pass
