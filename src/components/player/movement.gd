extends CharacterBody2D

const SPEED = 100.0
const SPRINT_MULTIPLIER = 2.0

const JUMP_HEIGHT = 35.0
const JUMP_TIME_PEAK = 0.3
const JUMP_TIME_DESCENT = 0.3

@onready var jump_velocity = ((2.0 * JUMP_HEIGHT) / JUMP_TIME_PEAK) * -1.0
@onready var jump_gravity = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_PEAK * JUMP_TIME_PEAK)) * -1.0
@onready var fall_gravity = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_DESCENT * JUMP_TIME_DESCENT)) * -1.0


func _get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity


func _physics_process(delta: float) -> void:
	velocity.y += _get_gravity() * delta

	var direction := Input.get_axis("Left", "Right")
	var sprint_multiplier := SPRINT_MULTIPLIER if Input.is_action_pressed("Sprint") else 1.0

	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity

	if direction:
		velocity.x = direction * SPEED * sprint_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
