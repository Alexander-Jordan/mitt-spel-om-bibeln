extends CharacterBody3D

const movement_speed_walking:float = 5.0
const movement_speed_sprinting:float = 8.0
const jump_velocity:float = 4.5
const mouse_sensitivity:float = 0.3

# get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var direction:Vector3 = Vector3.ZERO
var movement_lerp_speed:float = 10.0
var movement_speed_current:float = movement_speed_walking

@onready var player_head:Node3D = $head


func _ready():
	# hide & lock the mouse cursor, but still capture mouse movement
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):	
	# rotate player in x axis & the head in y axis according to the mouse movement
	# but only when mouse mode is set to CAPTURED
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-deg_to_rad(event.relative.x * mouse_sensitivity))
		player_head.rotate_x(-deg_to_rad(event.relative.y * mouse_sensitivity))
		player_head.rotation.x = clamp(player_head.rotation.x, deg_to_rad(-80.0), deg_to_rad(80.0))


func _physics_process(delta):
	# set speed to sprinting or walking
	movement_speed_current = movement_speed_sprinting if Input.is_action_pressed("sprint") else movement_speed_walking
	
	# add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	# get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	direction = lerp(
		direction,
		(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),
		delta * movement_lerp_speed,
	)
	if direction:
		velocity.x = direction.x * movement_speed_current
		velocity.z = direction.z * movement_speed_current
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed_current)
		velocity.z = move_toward(velocity.z, 0, movement_speed_current)

	move_and_slide()


func _on_game_state_component_paused_changed(paused):
	pass # Replace with function body.
