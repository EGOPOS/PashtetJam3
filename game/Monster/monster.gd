class_name Monster
extends Node3D

@export var max_hungry_level: float
@export var famine: float
@export var famine_tic: float

@export var max_player_lives: int = 20
var player_lives: int:
	set(value):
		player_lives = value
		Hud.set_player_lives(player_lives)
		
var player_to_hungry: float = max_hungry_level / max_player_lives

@onready var state_machine: MonsterStateMachine = $StateMachine
@onready var wall_area: Area3D = $Area
@onready var famine_timer: Timer = $FamineTimer

var velocity: Vector3
var hungry_level: float:
	set(value):
		hungry_level = value
		Hud.set_monster_hungry(hungry_level)

func _ready():
	player_lives = max_player_lives
	Hud.max_player_lives = max_player_lives
	
	hungry_level = max_hungry_level
	famine_timer.timeout.connect(make_famine)
	famine_timer.start(famine_tic)
	Enviroment.monster = self

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

func eat_player_lives():
	player_lives = clamp(player_lives, 0, max_player_lives)

func make_famine() -> void:
	hungry_level -= famine
	famine_timer.start(famine_tic)
