extends Control
class_name PlayerUIComponent

@onready var direct_child:Control = $Control
@onready var interact_control:Control = $Control/Interact

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func toggle_visibility():
	direct_child.visible = !direct_child.visible


func _on_sight_interactor_component_interact_changed(can_interact):
	interact_control.visible = can_interact
