extends Node3D

@onready var world_manager = $WorldManager
@onready var music_player = $AudioStreamPlayer

func _ready():
	Hud.settings._ready()
	music_player.play()
	world_manager.event_timer.start()
	#world_manager.start_event(world_manager.valid_events[world_manager.EVENTS.FLOOD])
	#world_manager.start_event(world_manager.EVENTS.FOG)
