extends Node
class_name LevelLoadComponent

func _on_level_select_load_scene_from_level(level):
	get_tree().change_scene_to_packed(level.scene)
