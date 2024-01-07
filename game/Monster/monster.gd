class_name Monster
extends Node3D

@export var max_hungry_level: float
@export var famine: float

@onready var state_machine: MonsterStateMachine = $StateMachine
@onready var wall_area: Area3D = $Area

var velocity: Vector3
var hungry_level: float

func _ready():
	wall_area.body_entered.connect(stop_moving)
	wall_area.body_exited.connect(continue_moving)
	state_machine.change_state("Moving")

func stop_moving(body) -> void:
	if body is WallObject:
		state_machine.change_state("Idle")

func continue_moving(body) -> void:
	if body is WallObject:
		state_machine.change_state("Moving")

func _process(delta):
	pass
