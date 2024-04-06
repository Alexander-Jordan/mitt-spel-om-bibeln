extends Node3D
class_name InteractionInitiatorComponent

var responder:InteractionResponderComponent = null : set = set_responder
var interaction:Interaction = null

signal play_audio(audio:AudioStream)
signal interaction_changed(interaction:Interaction)

func _process(delta):
	if responder != null:
		var current_interaction = responder.input_listener(self)
		if current_interaction != interaction:
			interaction = current_interaction
			interaction_changed.emit(interaction)

func set_responder(new_responder:InteractionResponderComponent):
	responder = new_responder
	if responder == null:
		interaction = null
		interaction_changed.emit(interaction)

func _play_audio(audio:AudioStream):
	play_audio.emit(audio)
