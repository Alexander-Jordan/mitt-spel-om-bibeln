extends Node3D

@onready var camera:Camera3D = $Camera3D
@onready var main_camera_position:Node3D = $MainCameraPosition
@onready var levels_camera_position:Node3D = $LevelsCameraPosition
@onready var credits_camera_position:Node3D = $CreditsCameraPosition

var target_transform:Transform3D
var move_camera_speed:float = 4.0

func _process(delta):
	if target_transform:
		camera.transform = camera.transform.interpolate_with(target_transform, delta * move_camera_speed)


func _on_menu_ui_menu_changed(to:String):
	if to == 'main':
		target_transform = main_camera_position.transform
	elif to == 'level':
		target_transform = levels_camera_position.transform
	elif to == 'credits':
		target_transform = credits_camera_position.transform
