extends Node3D
class_name InteractionInitiatorComponent

var responder:InteractionResponderComponent = null : set = set_responder
var interaction:Interaction = null

signal play_audio(audio:AudioStream)
signal interaction_changed(interaction:Interaction)

func _process(delta):
	if responder != null:
		var current_interaction = responder.one_interaction()
		if current_interaction == null:
			if interaction != null:
				interaction = null
				interaction_changed.emit(interaction)
			return
		
		if interaction != current_interaction:
			interaction = current_interaction
			interaction_changed.emit(interaction)
		interaction.input_listener(self)
	elif interaction != null:
		interaction = null
		interaction_changed.emit(interaction)

func set_responder(new_responder:InteractionResponderComponent):
	# drop old responder
	drop_responder_connection(self.responder)
	# establish connection and set new responder
	responder = establish_responder_connection(new_responder)

func drop_responder_connection(responder:InteractionResponderComponent):
	if responder == null:
		return
	
	responder.initiator = null

func establish_responder_connection(responder:InteractionResponderComponent) -> InteractionResponderComponent:
	if responder == null:
		return null
	
	responder.initiator = self
	
	return responder

func _play_audio(audio:AudioStream):
	play_audio.emit(audio)
