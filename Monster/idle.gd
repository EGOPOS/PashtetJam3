extends MonsterState

var famine_multiplier: float = 2

func _enter_state(monster: Monster) -> void:
	super(monster)
	target.famine *= famine_multiplier

func _exit_state() -> void:
	target.famine /= famine_multiplier
