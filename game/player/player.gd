extends CharacterBody3D

class_name Player

@export var movement_speed: float = 15
@export var air_speed_multiplier: float = 0.7
@export var jump_power: float = 25

@export var acceleration: float = 6
@export var friction: float = 12

@export var gravity = 1.0

@onready var item_marker_pivot = $Marker3D
@onready var item_marker = $Marker3D/Marker3D2

@onready var items_area = $Area3D
var current_item: Item = null

func _process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power

	var side_direction = Input.get_axis("movement_left", "movement_right")
	if side_direction:
		velocity.x = lerp(velocity.x, side_direction * movement_speed * (1 if is_on_floor() else air_speed_multiplier), acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
	
	move_and_slide()
	
	if current_item:
		current_item.global_position = lerp(current_item.global_position, item_marker.global_position, delta * 30)
		

func grab_item(item: Item):
	if current_item:
		current_item.freeze = false
	current_item = item
	current_item.freeze = true

func throw_item():
	current_item.freeze = false

func _input(event):
	if Input.is_action_just_pressed("interact"):
		for body in items_area.get_overlapping_bodies():
			if body is Item:
				grab_item(body)
				return
