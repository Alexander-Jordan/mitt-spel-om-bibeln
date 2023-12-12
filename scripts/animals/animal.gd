extends Node

signal animal_is_idle
signal animal_is_moving

@onready var state_timer: Timer = $state_timer

var states: Array = ['idle', 'moving']
var state: String = 'idle'
var rng = RandomNumberGenerator.new()

func _ready():
	set_state()


func _process(delta):
	pass


func set_state():
	var random_state_index = rng.randi_range(0, states.size() - 1)
	self.state = states[random_state_index]
	if (state == 'idle'):
		animal_is_idle.emit()
	if (state == 'moving'):
		animal_is_moving.emit()
	state_timer.start(rng.randf_range(1, 10))


func _on_state_timer_timeout():
	set_state()
