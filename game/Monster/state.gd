class_name MonsterState
extends RefCounted

var target: Monster
var animation_player: AnimationPlayer
var animation: String

func _enter_state(monster: Monster) -> void:
	target = monster
	animation_player = target.get_node("Hotel/AnimationPlayer")

func _update(delta) -> void:
	pass

func _exit_state() -> void:
	pass
