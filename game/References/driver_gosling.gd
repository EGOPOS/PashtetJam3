extends Node3D
class_name Driver

@export var speed: float
@onready var sounds: Array[AudioStreamPlayer3D] = [$Nightcall, $RealHero]

func _ready() -> void:
	sounds[randi() % sounds.size()].play(randi() % 10)

func _process(delta):
	var velocity: Vector3 = Vector3.RIGHT * speed * delta
	global_position += velocity

func _on_timer_timeout():
	queue_free()
