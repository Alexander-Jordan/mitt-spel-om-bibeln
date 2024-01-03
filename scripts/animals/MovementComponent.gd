extends CharacterBody3D
class_name MovementComponent

@export var movement_speed: float = 2.0
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
	# add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if target_position is Vector3:
		var n: Vector3 = raycast.get_collision_normal()
		if n.length_squared() < 0.001:
			n = Vector3(0, 1, 0)
		velocity = (target_position - transform.origin).slide(n).normalized() * movement_speed
		look_at(transform.origin + velocity, Vector3.UP, true)
	
	move_and_slide()

func _on_navigation_component_next_path_position(next_path_position: Variant):
	self.target_position = next_path_position
	# clear velocity if no next_path_position
	if next_path_position == null:
		velocity = Vector3.ZERO
