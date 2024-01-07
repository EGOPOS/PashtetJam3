extends Event

@export var driver: PackedScene

func _make_effect(player: Player, hotel_monster: Monster, env: WorldEnvironment) -> void:
	super(player, hotel_monster, env)
	spawn_driver()

func spawn_driver() -> void:
	var spawn_position: Vector3
	var man_who_drive: Driver = driver.instantiate()
	
	spawn_position.z = -37.5
	spawn_position.y = 21
	spawn_position.x = monster.position.x - 175
	
	man_who_drive.global_position = spawn_position
	get_tree().current_scene.add_child(man_who_drive)
