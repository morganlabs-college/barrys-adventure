extends CharacterBody2D

enum DIRECTIONS_X { STILL, RIGHT, LEFT }
enum DIRECTIONS_Y { RISING, FALLING, GROUND }

const ACCELERATION := 2500.0
const FRICTION := 800.0
const JUMP_HEIGHT := 70.0
const JUMP_TIME_PEAK := 0.5
const JUMP_TIME_DESCENT := 0.5

@export var speed := 200.0

var mana := 0

var has_jumped := false
var has_double_jumped := false
var direction_x := DIRECTIONS_X.STILL
var direction_y := DIRECTIONS_Y.GROUND

@onready var sprite := $AnimatedSprite2D

@onready var jump_velocity := ((2.0 * JUMP_HEIGHT) / JUMP_TIME_PEAK) * -1.0
@onready var jump_gravity := ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_PEAK * JUMP_TIME_PEAK)) * -1.0
@onready var fall_gravity := ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_DESCENT * JUMP_TIME_DESCENT)) * -1.0


func _get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity


func _physics_process(delta: float) -> void:
	velocity.y += _get_gravity() * delta

	handle_movement(delta)
	get_y_direction(delta)
	handle_jump()
	handle_animation()

	move_and_slide()

func handle_movement(delta: float):
	if Input.is_action_pressed("Move Left"):
		direction_x = DIRECTIONS_X.LEFT
		sprite.flip_h = true
	elif Input.is_action_pressed("Move Right"):
		direction_x = DIRECTIONS_X.RIGHT
		sprite.flip_h = false
	else:
		direction_x = DIRECTIONS_X.STILL

	if direction_x == DIRECTIONS_X.LEFT:
		velocity.x = move_toward(velocity.x, -1 * speed, ACCELERATION * delta)
	elif direction_x == DIRECTIONS_X.RIGHT:
		velocity.x = move_toward(velocity.x, 1 * speed, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)


func handle_jump():
	if Input.is_action_pressed("Jump"):
		if is_on_floor() and !has_jumped:
			velocity.y = jump_velocity
			has_jumped = true
			return

	if Input.is_action_just_pressed("Jump") and !is_on_floor() and !has_double_jumped:
		var multiplier = 0.75 if has_jumped else 1.0
		velocity.y = jump_velocity * multiplier
		direction_y = DIRECTIONS_Y.RISING
		has_double_jumped = true
		return

	if is_on_floor():
		has_jumped = false
		has_double_jumped = false


func handle_animation():
	if (direction_y == DIRECTIONS_Y.RISING) && (sprite.animation != "rising"):
		sprite.play("rising")
	elif (direction_y == DIRECTIONS_Y.FALLING) && (sprite.animation != "falling"):
		sprite.play("falling")
	elif (is_on_floor()) && (direction_y == DIRECTIONS_Y.GROUND) && (sprite.animation != "running"):
		sprite.play("running")


func get_y_direction(delta: float):
	if velocity.y < 0:
		direction_y = DIRECTIONS_Y.RISING
	elif velocity.y > (fall_gravity * delta):
		direction_y = DIRECTIONS_Y.FALLING
	else:
		direction_y = DIRECTIONS_Y.GROUND


func add_mana() -> void:
	mana += 1
	get_tree().call_group("Interface", "update_score", mana)
