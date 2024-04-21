extends Node3D
class_name DropComponent

@export var item:String
@onready var drop_location:PathFollow3D = $DropPath/DropLocation

signal drop_item(item_name:String, position:Vector3)

func drop():
	if item == '':
		return
	
	for _i in randi_range(1, 2):
		# set drop location to a random position on the path
		drop_location.progress_ratio = randf()
		# drop item at the random position
		drop_item.emit(item, drop_location.position)
		print(item, drop_location.position)
