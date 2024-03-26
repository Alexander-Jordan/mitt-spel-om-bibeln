extends Camera3D
class_name ScreenshotComponent

func _ready():
	var dir = DirAccess.open('user://')
	dir.make_dir('screenshots')

func _input(event):
	if event.is_action_pressed('screenshot'):
		screenshot()

func screenshot():
	await RenderingServer.frame_post_draw
	
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	img.save_png('user://screenshots/'+Time.get_datetime_string_from_system()+'.png')
