extends Node
class_name LevelLoadComponent

func _on_level_select_load_scene_from_level(level:Level):
	get_tree().change_scene_to_file(level.path)
