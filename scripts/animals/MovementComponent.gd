extends CharacterBody3D
class_name MovementComponent

@export var movement_speed: float = 2.0
# get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var target_position: Variant = null
var direction: Variant = null

func _physics_process(delta):
	# add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if direction is Vector3:
		velocity = Vector3(direction.x, velocity.y, direction.z) * movement_speed
		look_at(global_position + direction, Vector3.UP, true)
	
	move_and_slide()

func _on_navigation_component_next_path_position(next_path_position: Variant):
	self.target_position = next_path_position
	
	if next_path_position is Vector3:
		self.direction = global_position.direction_to(next_path_position)
		return
	
	self.direction = null
	velocity = Vector3.ZERO
