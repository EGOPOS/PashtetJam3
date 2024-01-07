extends Event

var animation_player: AnimationPlayer

func _make_effect(player: Player, hotel_monster: Monster, env: WorldEnvironment) -> void:
	super(player, hotel_monster, env)
	animation_player = monster.get_node("Hotel/AnimationPlayer")
	
	monster.state_machine.change_state("Idle")

	monster.down_area.body_entered.connect(lay_down)
	monster.down_area.body_exited.connect(stand_up)
	#var particles =

func _on_event_tic() -> void:
	var collisions: Array[Node3D] = monster.wall_area.get_overlapping_bodies()

func lay_down(body) -> void:
	if body is Player:
		animation_player.play("idleDwn")

func stand_up(body) -> void:
	if body is Player:
		animation_player.play_backwards("idleDwn")
		animation_player.queue("Pidle")

func _exit_event() -> void:
	monster.state_machine.change_state("Moving")
	super()
