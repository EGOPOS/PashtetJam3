extends Node

class_name Event

@export var event_time: float
@export var event_tic: float

@onready var event_tic_timer: Timer = $EventTicTimer

var target: Player
var monster: Monster
var enviroment: WorldEnvironment

func _make_effect(player: Player, hotel_monster: Monster, env: WorldEnvironment) -> void:
	var event_timer: SceneTreeTimer = get_tree().create_timer(event_time)
	event_timer.timeout.connect(_exit_event)
	event_tic_timer.timeout.connect(_on_event_tic)

	target = player
	monster = hotel_monster
	enviroment = env

func _on_event_tic() -> void:
	pass

func _exit_event() -> void:
	queue_free()
