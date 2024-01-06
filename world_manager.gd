class_name WorldManager
extends Node3D

@export var event_start_delta: float

enum EVENTS{RAIN, FLOOD, FOG}

var events: Dictionary = {
	EVENTS.RAIN : "",
	EVENTS.FLOOD : "",
	EVENTS.FOG: ""
}

func start_event() -> void:
	pass

func _ready():
	pass
