extends Interaction
class_name MoveToInitiatorInteraction

func pre_execution_setup(_responder:InteractionResponderComponent, initiator:InteractionInitiatorComponent):
	# objective to go to the initiator
	var move_to_caller_objective:Objective = MoveObjective.new()
	move_to_caller_objective.min_time = 60
	move_to_caller_objective.max_time = 120
	move_to_caller_objective.target = initiator.global_position
	# objective to stay at the place when reached
	var stay_in_place_objective:Objective = IdleObjective.new()
	stay_in_place_objective.min_time = 60
	stay_in_place_objective.max_time = 120
	# add both objectives, with the first to be executed last
	objectives.append(stay_in_place_objective)
	objectives.append(move_to_caller_objective)
