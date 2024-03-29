extends CharacterBody3D

class_name Player

@export var movement_speed: float = 15
@export var air_speed_multiplier: float = 0.7
@export var jump_power: float = 10

@export var acceleration: float = 8
@export var friction: float = 6

@export var gravity = 20

@onready var item_marker = $Marker3D/Marker3D2
@onready var animation_player = $model/AnimationPlayer
var animation = "Pidle"

@onready var model = $model

@onready var items_area = $Area3D
@onready var take_audio_player: AudioStreamPlayer3D = $TakeAudioPlayer
@onready var drop_audio_player: AudioStreamPlayer3D = $DropAudioPlayer
@onready var spawn_audio_player: AudioStreamPlayer3D = $SpawnAudioPlayer
var current_item: Item = null

func _process(delta):
	velocity.z = 0
	
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor() and not current_item:
		animation_player.play("jump")
		velocity.y = jump_power

	var side_direction = Input.get_axis("movement_left", "movement_right")
	if side_direction:
		velocity.x = lerp(velocity.x, side_direction * movement_speed * (1 if is_on_floor() else air_speed_multiplier), acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
	
	move_and_slide()
	
	if current_item:
		current_item.global_position = lerp(current_item.global_position, item_marker.global_position, delta * 30)
	
	model.rotation_degrees.y = lerp(model.rotation_degrees.y, 90.0 * sign(round(velocity.x)) if sign(round(velocity.x)) != 0 else model.rotation_degrees.y, delta * 16.0)
	
	update_animation()
	if animation_player.current_animation != "DropItem" and animation_player.current_animation != "UpItem" and animation_player.current_animation != "jump" or animation_player.current_animation == "run" or animation_player.current_animation == "UpItem_run":
		animation_player.play(animation)

func update_animation():
	if round(velocity.y) == 0:
		if round(abs(velocity.x)) > 0:
			animation = "UpItem_run" if current_item != null else "run"
		elif round(abs(velocity.x)) == 0:
			animation = "UpItem_idle" if current_item != null else "Pidle"
	elif velocity.y < 0:
		animation = "jumpDown"

func grab_item(item: Item):
	if current_item:
		await throw_item()
	
	take_audio_player.play()
	animation_player.play("UpItem")
	await animation_player.animation_finished
	
	current_item = item
	current_item.freeze = true

func throw_item():
	drop_audio_player.play()
	animation_player.play("DropItem")
	await animation_player.animation_finished
	if not current_item:
		return
	current_item.freeze = false
	current_item.reparent(get_tree().current_scene)
	current_item.apply_central_impulse(Vector3(velocity.normalized().x, 1, 0) * 10.0)
	current_item = null

func _input(event):
	if Input.is_action_just_pressed("interact"):
		for body in items_area.get_overlapping_bodies():
			if body is Item:
				grab_item(body)
				return
		if current_item:
			throw_item()

func die():
	const PLAYER_BODY = preload("res://assets/player_body.tscn")
	var body_instance = PLAYER_BODY.instantiate()
	get_tree().current_scene.add_child(body_instance)
	body_instance.global_position = global_position - Vector3(0, 0.5, 0)
	
	current_item = null
	
	var monster = get_tree().current_scene.get_node("Monster")
	global_position = monster.player_spawn_marker.global_position
	monster.player_lives -= 1
	spawn_audio_player.play()
