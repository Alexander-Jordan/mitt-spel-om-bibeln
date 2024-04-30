extends Node
class_name LevelLoadComponent

@export var progress_bar:ProgressBar

var level_being_loaded:Level = null

func _process(_delta):
	if level_being_loaded != null:
		var process:Array = []
		var status:int = ResourceLoader.load_threaded_get_status(level_being_loaded.path, process)
		progress_bar.value = process[0] * 100
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(level_being_loaded.path))

func _on_level_select_load_scene_from_level(level:Level):
	ResourceLoader.load_threaded_request(level.path)
	level_being_loaded = level
