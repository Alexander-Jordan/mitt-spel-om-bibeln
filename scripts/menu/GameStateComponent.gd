extends Node
class_name GameStateComponent

@onready var pause_menu:PauseComponent = $PauseMenu

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		pause_menu.toggle_pause()
