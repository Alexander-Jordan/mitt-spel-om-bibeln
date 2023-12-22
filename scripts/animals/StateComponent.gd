extends Node
class_name StateComponent

signal state_changed(state:String)

var state: String

func set_state(state: String):
	self.state = state
	state_changed.emit(state)
