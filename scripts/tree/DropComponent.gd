extends Node3D
class_name DropComponent

@onready var drop_location:PathFollow3D = $DropPath/DropLocation

signal drop_item(position:Vector3)

func drop():
	for _i in randi_range(1, 2):
		# set drop location to a random position on the path
		drop_location.progress_ratio = randf()
		# drop item at the random position
		drop_item.emit(drop_location.global_position)
