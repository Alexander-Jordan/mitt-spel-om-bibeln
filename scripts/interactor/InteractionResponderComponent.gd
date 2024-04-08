extends Node3D
class_name InteractionResponderComponent

@export var interactions:Array[Interaction] = []
var active_interaction:Interaction = null

signal play_responder_audio(audio:AudioStream)
signal execute_objectives(objectives:Array[Objective])

func reachable_interactions(initiator:InteractionInitiatorComponent) -> Array[Interaction]:
	var distance:float = self.global_position.distance_to(initiator.global_position)
	return interactions.filter(func (i:Interaction): return distance <= i.max_distance)

func one_interaction(initiator:InteractionInitiatorComponent) -> Interaction:
	var filtered_interactions:Array[Interaction] = reachable_interactions(initiator)
	return null if filtered_interactions.is_empty() else filtered_interactions[0]

func input_listener(initiator:InteractionInitiatorComponent) -> Interaction:
	active_interaction = one_interaction(initiator)
	if active_interaction == null:
		return null
	
	if Input.is_action_just_pressed(active_interaction.input_action_name):
		execute_action(initiator)
	
	return active_interaction

func execute_action(initiator:InteractionInitiatorComponent):
	# first run pre-setup which is unique per interaction
	active_interaction.pre_execution_setup(self, initiator)
	
	if active_interaction.initiator_audio != null:
		initiator.play_audio.emit(active_interaction.initiator_audio)
	if active_interaction.responder_audio != null:
		play_responder_audio.emit(active_interaction.responder_audio)
	if not active_interaction.objectives.is_empty():
		execute_objectives.emit(active_interaction.objectives)
