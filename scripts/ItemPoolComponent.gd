extends Node3D
class_name ItemPoolComponent

var items:Array[Node3D]
@export var item_scene:PackedScene
@export_range(1, 50) var max_items:int = 20

func new_item() -> Node3D:
	var item = item_scene.instantiate()
	add_child(item)
	items.append(item)
	return item

func get_item() -> Node3D:
	# always add a new item if no items has been added
	if items.is_empty():
		return new_item()
	# get the first item that is not used if max items is not reached yet
	elif items.size() < max_items:
		for item in items:
			if !item.visible:
				return item
		return new_item()
	# get the oldest item if all are used, but it's not allowed to add more
	var item:Node3D = items.pop_front()
	items.append(item)
	return item

func spawn_item(pos:Vector3):
	var item:Node3D = self.get_item()
	item.position = pos
	item.visible = true

func destroy_item(item:Node3D):
	item.visible = false
	item.position = Vector3.ZERO

func _on_spawn_item(pos:Vector3):
	spawn_item(pos)
