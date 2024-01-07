extends Node3D

@onready var world_manager = $WorldManager

func _ready():
	#pass
	world_manager.start_event(world_manager.EVENTS.RAIN)

