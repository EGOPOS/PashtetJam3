class_name WorldManager
extends Node3D

@export var event_time_difference: float

@onready var event_timer: Timer = $Timer
@onready var monster: Monster = get_tree().current_scene.get_node("Monster")
@onready var player: Player = get_tree().current_scene.get_node("Player")
@onready var world_env: WorldEnvironment = get_tree().current_scene.get_node("WorldEnvironment")

enum EVENTS{RAIN, FLOOD, FOG, DRIVER}

var valid_events: Array[EVENTS] = [EVENTS.RAIN, EVENTS.FLOOD, EVENTS.FOG, EVENTS.DRIVER]

var events: Dictionary = {
	EVENTS.RAIN : "res://game/InteractionObjects/Events/rain.tscn",
	EVENTS.FLOOD : "res://game/InteractionObjects/Events/flood.tscn",
	EVENTS.FOG: "res://game/InteractionObjects/Events/fog.tscn",
	EVENTS.DRIVER: "res://game/InteractionObjects/Events/driver.tscn"
}

func _ready() -> void:
	event_timer.timeout.connect(check_event_valid)
	event_timer.wait_time = event_time_difference

func check_event_valid() -> void:
	var new_event: EVENTS = EVENTS.DRIVER
	if !valid_events.is_empty():
		new_event = valid_events[randi() % valid_events.size()]
	start_event(new_event)

func start_event(new_event: EVENTS) -> void:
	var event: Event = load(events[new_event]).instantiate()
	add_child(event)
	event._make_effect(player, monster, world_env)
	valid_events.erase(new_event)
