extends Control

@onready var main_ui_container:Control = $MarginContainer/VBoxContainer/Main
@onready var level_select_ui_container:Control = $MarginContainer/VBoxContainer/LevelSelect
@export var button_pressed_audio_stream_player:AudioStreamPlayer

signal menu_changed(to:String)

func _ready():
	$MarginContainer/VBoxContainer/Main/VBoxContainer/StartButton.grab_focus()


func _on_start_button_pressed():
	if button_pressed_audio_stream_player:
		button_pressed_audio_stream_player.play()
	main_ui_container.visible = false
	level_select_ui_container.visible = true
	menu_changed.emit('level')


func _on_quit_button_pressed():
	if button_pressed_audio_stream_player:
		button_pressed_audio_stream_player.play(0.2)
	get_tree().quit()


func _on_level_select_back_button_pressed():
	if button_pressed_audio_stream_player:
		button_pressed_audio_stream_player.play(0.2)
	level_select_ui_container.visible = false
	main_ui_container.visible = true
	menu_changed.emit('main')
