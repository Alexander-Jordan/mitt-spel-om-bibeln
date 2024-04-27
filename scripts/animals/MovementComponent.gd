extends CharacterBody3D
class_name MovementComponent

@export var movement_speed: float = 2.0
@export_range (-1.0, 1.0) var rotation_speed: float = 0.08
# get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var target_position: Variant = null
var raycast: RayCast3D

func _ready():
	for child in get_children():
		if child is RayCast3D:
			raycast = child
			break
	
	assert(raycast != null, "A RayCast3D is required as child node")

func _physics_process(delta):
	if target_position is Vector3:
		transform = transform.interpolate_with(transform.looking_at(target_position, Vector3.UP, true), rotation_speed)
		velocity = transform.basis.z.normalized() * movement_speed
	
	move_and_slide()

func _on_navigation_component_next_path_position(next_path_position: Variant):
	self.target_position = next_path_position
	# clear velocity if no next_path_position
	if next_path_position == null:
		velocity = Vector3.ZERO
