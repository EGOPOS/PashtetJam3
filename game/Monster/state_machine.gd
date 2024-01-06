extends Node3D
class_name MonsterStateMachine

var current_state: String
var current_state_script: MonsterState = MonsterState.new()

var states: Dictionary = {
	"Idle" : "res://game/Monster/idle.gd",
	"Moving" : "res://game/Monster/moving.gd"
}

func _process(delta):
	current_state_script._update(delta)

func change_state(new_state: String) -> void:
	if current_state == new_state:
		return

	current_state_script._exit_state()
	current_state_script = load(states[new_state]).new()
	current_state_script._enter_state(get_parent())
	
	current_state = new_state
