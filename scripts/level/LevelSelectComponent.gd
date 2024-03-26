extends Node
class_name LevelSelectComponent

@export var levels:Array[Level]
var current_level:Level

@onready var name_label:Label = $HBoxContainer2/VBoxContainer/LevelName
@onready var image_texture_rect:TextureRect = $HBoxContainer2/VBoxContainer/HBoxContainer/LevelImage
@onready var description_label:Label = $HBoxContainer2/VBoxContainer/HBoxContainer/LevelDescription

signal load_scene_from_level(level:Level)

func _ready():
	if levels.is_empty():
		return
	current_level = levels[0]
	level_changed()

func level_changed():
	name_label.text = current_level.name
	description_label.text = current_level.description
	image_texture_rect.texture = current_level.image

func next_level():
	if levels.is_empty():
		return
	var next_index = levels.find(current_level) + 1
	next_index = 0 if next_index >= levels.size() else next_index
	current_level = levels[next_index]
	level_changed()

func previous_level():
	if levels.is_empty():
		return
	var previous_index = levels.find(current_level)
	previous_index = levels.size() - 1 if previous_index <= 0 else previous_index - 1
	current_level = levels[previous_index]
	level_changed()

func _on_previous_button_pressed():
	previous_level()

func _on_next_button_pressed():
	next_level()

func _on_load_level_button_pressed():
	load_scene_from_level.emit(current_level)
