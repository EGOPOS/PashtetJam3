class_name Parallax
extends Node3D

@export var sprite: Sprite3D
@export var speed_multiplier: float

var previous_position: Vector3 = Vector3.ZERO

func _process(delta):
	var camera: Camera3D = get_viewport().get_camera_3d()
	var camera_position: Vector3 = camera.global_position
	sprite.global_position += (camera_position - previous_position) * speed_multiplier * delta
	previous_position = camera_position
