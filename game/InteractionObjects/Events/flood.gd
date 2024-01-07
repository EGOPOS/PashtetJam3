extends Event

const WATER_LEVEL = preload("res://assets/water_level.tscn")
var water_instance

func _make_effect(player: Player, hotel_monster: Monster, env: WorldEnvironment) -> void:
	super(player, hotel_monster, env)
	water_instance = WATER_LEVEL.instantiate()
	print(1)
	get_tree().current_scene.add_child(water_instance)
	print(water_instance.get_parent().name)
	water_instance.global_position.y = -5
	await get_tree().create_tween().tween_property(water_instance, "position", Vector3(0, -2, 0), 1.5).finished
	print(2)
	player.air_speed_multiplier *= 0.5
	player.movement_speed *= 0.5

func _exit_event() -> void:
	target.air_speed_multiplier /= 0.5
	target.movement_speed /= 0.5
	
	await get_tree().create_tween().tween_property(water_instance, "global_position", Vector3(0, -5, 0), 1.5).finished
	water_instance.queue_free()
