extends Control

@onready var main_ui_container:Control = $MarginContainer/VBoxContainer/Main
@onready var level_select_ui_container:Control = $MarginContainer/VBoxContainer/LevelSelect

signal menu_changed(to:String)

func _ready():
	$MarginContainer/VBoxContainer/Main/VBoxContainer/StartButton.grab_focus()


func _on_start_button_pressed():
	main_ui_container.visible = false
	level_select_ui_container.visible = true
	menu_changed.emit('level')


func _on_quit_button_pressed():
	get_tree().quit()


func _on_level_select_back_button_pressed():
	level_select_ui_container.visible = false
	main_ui_container.visible = true
	menu_changed.emit('main')


func _on_level_select_load_level_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/test_level.tscn")
