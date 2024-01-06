extends MonsterState

var velocity_speed: float = 100
var direction: Vector3 = Vector3.RIGHT
var velocity: Vector3

func _enter_state(monster: Monster) -> void:
	super(monster)

func _update(delta) -> void:
	velocity = target.velocity
	velocity = lerp(velocity, direction * velocity_speed, 0.1)
	target.global_position += velocity * delta

func _exit_state() -> void:
	direction = Vector3.ZERO
