extends Node3D
class_name InteractionResponderComponent

@export var interactions:Array[Interaction] = []
var initiator:InteractionInitiatorComponent = null

signal play_responder_audio(audio:AudioStream)
signal execute_objectives(objectives:Array[Objective])

func _ready():
	for interaction in interactions:
		interaction.responder = self

func reachable_interactions() -> Array[Interaction]:
	if initiator == null:
		return []
	
	var distance:float = self.global_position.distance_to(initiator.global_position)
	return interactions.filter(func (i:Interaction): return distance <= i.max_distance)

func one_interaction() -> Interaction:
	var reachable_interactions:Array[Interaction] = reachable_interactions()
	return null if reachable_interactions.is_empty() else reachable_interactions[0]
