extends Node3D
class_name SituationAwarenessComponent

var area_close: Area3D
var area_far: Area3D
var animal_objectives: AnimalObjectives

@export var player_is_close_objective: Objective

func _ready():
	for child in get_children():
		if child is Area3D:
			if child.name == 'AreaClose':
				area_close = child
				continue
			if child.name == 'AreaFar':
				area_far = child
				continue
		if child is AnimalObjectives:
			animal_objectives = child
	
	assert(area_close != null, '"AreaClose" (Area3D) is required as child node')
	assert(area_far != null, '"AreaFar" (Area3D) is required as child node')
	assert(animal_objectives != null, 'AnimalObjectives is required as child node')
	
	for area in [area_close, area_far]:
		area.body_entered.connect(func(body: Node3D): _area3D_body_entered(body, area))
		area.body_exited.connect(func(body: Node3D): _area3D_body_exited(body, area))
		

func _area3D_body_entered(body: Node3D, area: Area3D):
	if area == area_close:
		if body.name == 'player':
			player_entered_close()
	if area == area_far:
		pass

func _area3D_body_exited(body: Node3D, area: Area3D):
	if area == area_close:
		if body.name == 'player':
			player_exited_close()
	if area == area_far:
		pass

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
