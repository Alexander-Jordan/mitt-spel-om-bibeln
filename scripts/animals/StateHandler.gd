extends Node
class_name StateHandler

var state_timer: Timer

signal state_changed(state:String)

@export var states: Array
@onready var state: String = states[0]
var rng = RandomNumberGenerator.new()


func _ready():
	for child in get_children():
		if child is Timer:
			state_timer = child
	
	if state_timer == null:
		assert(false, "Timer node is required as a child node")
	
	state_timer.timeout.connect(_on_state_timer_timeout)
	set_state()


func _process(_delta):
	pass


func set_state():
	var random_state_index = rng.randi_range(0, states.size() - 1)
	self.state = states[random_state_index]
	state_changed.emit(state)
	state_timer.start(rng.randf_range(1, 10))


func _on_state_timer_timeout():
	set_state()
