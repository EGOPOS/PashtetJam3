extends Event

@export var hp_step: float

@onready var audio_player: AudioStreamPlayer = $Audio

var animation_player: AnimationPlayer
var final_state: String
var max_player_hp: float = 100
var player_hp: float = 100:
	set(new_hp):
		player_hp = new_hp
		if player_hp <= 0:
			target.die()
			player_hp = max_player_hp
		Hud.change_vignette_visibility((max_player_hp - player_hp) / 100.0)

func _make_effect(player: Player, hotel_monster: Monster, env: WorldEnvironment) -> void:
	super(player, hotel_monster, env)
	final_state = monster.state_machine.current_state
	smooth_audio(0)
	animation_player = monster.get_node("Hotel/AnimationPlayer")
	
	monster.state_machine.change_state("Idle")

	monster.down_area.body_entered.connect(lay_down)
	monster.down_area.body_exited.connect(stand_up)

func smooth_audio(db: float) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(audio_player, "volume_db", db, 0.2)

func _on_event_tic() -> void:
	var collisions: Array[Node3D] = monster.wall_area.get_overlapping_bodies()
	if monster.down_area.get_overlapping_bodies().find(target) == -1:
		player_hp -= hp_step

func lay_down(body) -> void:
	if body is Player:
		animation_player.play("idleDwn")
		#player_hp = max_player_hp

func stand_up(body) -> void:
	if body is Player:
		animation_player.play_backwards("idleDwn")
		animation_player.queue("Pidle")

func _exit_event() -> void:
	monster.state_machine.change_state(final_state)
	smooth_audio(-80)
	Hud.change_vignette_visibility(0)
	super()
