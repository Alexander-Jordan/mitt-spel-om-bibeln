extends Control
class_name PlayerUIComponent

@onready var direct_child:Control = $Control
@onready var interact_control:Control = $Control/Interact
@onready var interact_label:Label = $Control/Interact/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func toggle_visibility():
	direct_child.visible = !direct_child.visible

func _on_interaction_initiator_component_interaction_changed(interaction:Interaction):
	interact_control.visible = true if interaction != null else false
	if interaction == null:
		return
	
	interact_label.text = ' (E)' if interaction.input_action_name == 'interact' else ''
	interact_label.text = interaction.name + interact_label.text
