extends Event

var world: Environment

func _make_effect(player: Player, hotel_monster: Monster, env: WorldEnvironment) -> void:
	super(player, hotel_monster, env)
	world = enviroment.environment #need to add tween
	world.volumetric_fog_enabled = true

func _exit_event() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(world, "volumetric_fog_density", -8, 1)
	world.volumetric_fog_density = 0.05
	super()
