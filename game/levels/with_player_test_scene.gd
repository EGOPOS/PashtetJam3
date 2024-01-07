extends Node3D

@onready var world_manager = $WorldManager


func _ready():
	world_manager.start_event(world_manager.valid_events[world_manager.EVENTS.FLOOD])

