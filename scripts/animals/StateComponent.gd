extends Node
class_name StateComponent

signal state_changed(state:String)

var state: String : set = set_state

func set_state(new_state: String):
	state = new_state
	state_changed.emit(state)
