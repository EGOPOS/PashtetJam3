class_name WorldManager
extends Node3D

@export var event_start_delta: float
@export var event_time_difference: float

@onready var event_timer: Timer = $Timer

var monster: Monster
var player: Player
var world_env: WorldEnvironment

enum EVENTS{RAIN, FLOOD, FOG, DRIVER}

var valid_events: Array[EVENTS] = [EVENTS.RAIN, EVENTS.FLOOD, EVENTS.FOG, EVENTS.DRIVER]

var events: Dictionary = {
	EVENTS.RAIN : "",
	EVENTS.FLOOD : "",
	EVENTS.FOG: "",
	EVENTS.DRIVER: ""
}

func _ready() -> void:
	event_timer.timeout.connect(check_event_valid)
	event_timer.wait_time = event_time_difference

func check_event_valid() -> void:
	var monsters_count: int #Will increase this after merge
	var new_event: EVENTS = valid_events[randi() % monsters_count]
	start_event(new_event)

func start_event(new_event: EVENTS) -> void:
	var event: Event = load(events[new_event]).instantiate()
	add_child(event)
	event._make_effect(player, monster, world_env)
	valid_events.erase(new_event)
