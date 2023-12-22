extends CharacterBody3D
class_name MovementComponent

const movement_speed:float = 2.0
# get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var direction: Vector3 = Vector3.ZERO

func _physics_process(delta):
	# add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if direction:
		velocity = Vector3(direction.x, velocity.y, direction.z) * movement_speed
		look_at(global_position + direction, Vector3.UP, true)
	
	move_and_slide()

func _on_navigation_component_current_direction(direction):
	self.direction = direction
	velocity = Vector3.ZERO
