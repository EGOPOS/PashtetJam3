extends Event

const WATER_LEVEL = preload("res://assets/water_level.tscn")
var water_instance = WATER_LEVEL.instantiate()

func _make_effect(player: Player, hotel_monster: Monster, env: WorldEnvironment) -> void:
	super(player, hotel_monster, env)
	
	player.get_parent().add_child(water_instance)
	water_instance.global_position.y = -3
	await get_tree().create_tween().tween_property(water_instance, "global_position", Vector3(0, -1, 0), 1.5).finished
	
	player.air_speed_multiplier *= 0.5
	player.movement_speed *= 0.5

func _exit_event() -> void:
	target.air_speed_multiplier /= 0.5
	target.movement_speed /= 0.5
	
	await get_tree().create_tween().tween_property(water_instance, "global_position", Vector3(0, -5, 0), 1.5).finished
	water_instance.queue_free()
