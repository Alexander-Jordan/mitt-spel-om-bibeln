extends AudioStreamPlayer
class_name AudioPlayerComponent

func _on_interaction_initiator_component_play_audio(audio:AudioStream):
	stream = audio
	play()
