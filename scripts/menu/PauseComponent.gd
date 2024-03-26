extends Control
class_name PauseComponent

@export var button_pressed_audio_stream_player:AudioStreamPlayer

@onready var direct_child: Control = $MarginContainer
@onready var resume_button: Button = $"MarginContainer/VBoxContainer2/MarginContainer2/VBoxContainer/Resume"
@onready var exit_button: Button = $"MarginContainer/VBoxContainer2/MarginContainer2/VBoxContainer/Exit"

# Called when the node enters the scene tree for the first time.
func _ready():
	resume_button.pressed.connect(unpause)
	exit_button.pressed.connect(load_main_menu)

func toggle_pause():
	if (get_tree().paused == true):
		unpause()
	else:
		pause()

func unpause():
	get_tree().paused = false
	if button_pressed_audio_stream_player:
		button_pressed_audio_stream_player.play(0.2)
	direct_child.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func pause():
	if button_pressed_audio_stream_player:
		button_pressed_audio_stream_player.play(0.2)
	direct_child.visible = true
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func load_main_menu():
	get_tree().paused = false
	if button_pressed_audio_stream_player:
		button_pressed_audio_stream_player.play(0.2)
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")
