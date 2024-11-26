extends CharacterBody2D

const SPEED := 125.0
const SPRINT_MULTIPLIER := 2.0

const JUMP_HEIGHT := 35.0
const JUMP_TIME_PEAK := 0.3
const JUMP_TIME_DESCENT := 0.3

var has_double_jumped := false

@onready var sprite = $AnimatedSprite2D

@onready var jump_velocity = ((2.0 * JUMP_HEIGHT) / JUMP_TIME_PEAK) * -1.0
@onready var jump_gravity = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_PEAK * JUMP_TIME_PEAK)) * -1.0
@onready var fall_gravity = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_DESCENT * JUMP_TIME_DESCENT)) * -1.0


func _get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity


func _physics_process(delta: float) -> void:
	velocity.y += _get_gravity() * delta

	handle_jump()
	handle_movement()
	handle_animation()

	move_and_slide()


func handle_jump():
	if Input.is_action_pressed("Jump"):
		if is_on_floor():
			velocity.y = jump_velocity

	if Input.is_action_just_pressed("Jump") and !is_on_floor() and !has_double_jumped:
		velocity.y = jump_velocity / 1.25
		has_double_jumped = true

	if is_on_floor():
		has_double_jumped = false


func handle_movement():
	var direction := Input.get_axis("Left", "Right")
	var sprint_multiplier := SPRINT_MULTIPLIER if Input.is_action_pressed("Sprint") else 1.0

	if direction:
		velocity.x = direction * SPEED * sprint_multiplier

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func handle_animation():
	if !is_on_floor() && velocity.y < 0:
		sprite.play("rising")
		return
	if !is_on_floor() && velocity.y > 0:
		sprite.play("falling")
		return

	sprite.play("running")
