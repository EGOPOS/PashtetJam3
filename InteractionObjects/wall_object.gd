extends RigidBody3D
class_name WallObject

func _input(event):
	if event.is_action_pressed("ui_accept"):
		queue_free()
