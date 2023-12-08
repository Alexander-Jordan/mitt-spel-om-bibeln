extends AnimationTree


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rabbit_animal_is_idle():
	set("parameters/conditions/idle", true)
	set("parameters/conditions/is_moving", false)


func _on_rabbit_animal_is_moving():
	set("parameters/conditions/idle", false)
	set("parameters/conditions/is_moving", true)
