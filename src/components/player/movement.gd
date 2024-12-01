extends CharacterBody2D

enum DIRECTIONS { RISING, FALLING, FORWARD }

const SPEED := 200.0
const JUMP_HEIGHT := 70.0
const JUMP_TIME_PEAK := 0.5
const JUMP_TIME_DESCENT := 0.5

var has_double_jumped := false

var direction := DIRECTIONS.FORWARD

@onready var sprite = $AnimatedSprite2D

@onready var jump_velocity = ((2.0 * JUMP_HEIGHT) / JUMP_TIME_PEAK) * -1.0
@onready var jump_gravity = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_PEAK * JUMP_TIME_PEAK)) * -1.0
@onready var fall_gravity = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_DESCENT * JUMP_TIME_DESCENT)) * -1.0


func _get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity


func _physics_process(delta: float) -> void:
	velocity.y += _get_gravity() * delta
	velocity.x = SPEED

	get_direction(delta)
	handle_jump()
	handle_animation()

	move_and_slide()


func handle_jump():
	if Input.is_action_pressed("Jump"):
		if is_on_floor():
			velocity.y = jump_velocity
			return

	if Input.is_action_just_pressed("Jump") and !is_on_floor() and !has_double_jumped:
		velocity.y = jump_velocity / 1.25
		direction = DIRECTIONS.RISING
		has_double_jumped = true

	if is_on_floor():
		has_double_jumped = false


func handle_animation():
	if (direction == DIRECTIONS.RISING) && (sprite.animation != "rising"):
		sprite.play("rising")
	elif (direction == DIRECTIONS.FALLING) && (sprite.animation != "falling"):
		sprite.play("falling")
	elif (is_on_floor()) && (direction == DIRECTIONS.FORWARD) && (sprite.animation != "running"):
		sprite.play("running")


func get_direction(delta: float):
	if velocity.y < 0:
		direction = DIRECTIONS.RISING
	elif velocity.y > (fall_gravity * delta):
		direction = DIRECTIONS.FALLING
	else:
		direction = DIRECTIONS.FORWARD
