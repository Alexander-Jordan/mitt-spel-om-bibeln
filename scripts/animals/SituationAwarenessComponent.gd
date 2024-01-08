extends Node3D
class_name SituationAwarenessComponent

var area_close: Area3D
var animal_objectives: AnimalObjectives

@export var player_is_close_objective: Objective

func _ready():
	for child in get_children():
		if child is Area3D:
			area_close = child
		if child is AnimalObjectives:
			animal_objectives = child
	
	assert(area_close != null, 'Area3D is required as child node')
	assert(animal_objectives != null, 'AnimalObjectives is required as child node')
	
	area_close.body_entered.connect(_area3D_body_entered)
	area_close.body_exited.connect(_area3D_body_exited)
		

func _area3D_body_entered(body: Node3D):
	if body.name == 'player':
		player_entered_close()

func _area3D_body_exited(body: Node3D):
	if body.name == 'player':
		player_exited_close()

func player_entered_close():
	if player_is_close_objective != null:
		animal_objectives.add_objective(
			player_is_close_objective.duplicate(true),
			true
		)
		animal_objectives.objectives.next_in_queue()

func player_exited_close():
	if player_is_close_objective != null:
		animal_objectives.objectives.next_in_queue()
