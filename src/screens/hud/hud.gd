extends CanvasLayer

@export var time_left := 300.0

@onready var timer := $TimeLimit
@onready var delay_restart := $DelayRestart

@onready var timer_gui := $GameInfoContainer/Margins/GameInfo/Timer
@onready var score := $GameInfoContainer/Margins/GameInfo/ManaCounter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if time_left != -1:
		timer.wait_time = time_left
		timer.start()

	update_score(0)
	update_timer()

func _process(delta: float) -> void:
	if time_left == -1:
		timer_gui.text = "No Time Limit"
	elif time_left > 0:
		time_left -= delta
		update_timer()
	else:
		timer_gui.text = "Time's Up!"


func update_score(mana: int) -> void:
	score.text = str("Mana: ", mana)

func update_timer() -> void:
	timer_gui.text = str("Time Remaining: ", ceil(time_left), "s")

func _on_time_limit_timeout() -> void:
	delay_restart.start()

func _on_delay_restart_timeout() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
