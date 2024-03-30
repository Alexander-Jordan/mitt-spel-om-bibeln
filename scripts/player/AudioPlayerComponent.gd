extends AudioStreamPlayer
class_name AudioPlayerComponent

func _on_sight_interactor_component_play_audio(audio:AudioStream):
	print(audio)
	#stream = audio
	print(stream)
	play()
