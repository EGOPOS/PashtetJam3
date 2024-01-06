extends Area3D

@export var one_shot: bool = false

@export var action_object: Node3D
@export var action_object_is_player: bool = false

@export var action_function: String = "action"
@export var object_is_argument: bool = false
@export var object: Node

@export var function_arguments: Array[Variant] = []

@export var expected_action: String = "interact"

@export_multiline
var action_details: String = ""

var player: Player

func _ready():
	var body_entered_solver = func(body):
		if body is Player:
			player = body
	
	var body_exited_solver = func(body):
		if body is Player:
			player = null
	
	body_entered.connect(body_entered_solver)
	body_exited.connect(body_exited_solver)

func _input(event):
	if not player:
		return
	if Input.is_action_just_pressed(expected_action):
		if not action_object_is_player:
			if not is_instance_valid(action_object):
				return
		else:
			action_object = player
			
		if object_is_argument:
			action_object.call(action_function, object)
		elif function_arguments.size() > 0:
			action_object.callv(action_function, function_arguments)
		else:
			action_object.call(action_function)
			
		if one_shot:
			queue_free()
