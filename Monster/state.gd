class_name MonsterState
extends RefCounted

var target: Monster

func _enter_state(monster: Monster) -> void:
	target = monster

func _update(delta) -> void:
	pass

func _exit_state() -> void:
	pass
