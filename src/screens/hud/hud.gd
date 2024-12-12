extends CanvasLayer

var attempt := 0
var mana_collected := 0

@onready var attempts := $GameInfoContainer/Margins/GameInfo/AttemptsCounter
@onready var score := $GameInfoContainer/Margins/GameInfo/ManaCounter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score()
	update_attempts()


func update_score() -> void:
	score.text = str("Mana: ", mana_collected)


func update_attempts() -> void:
	attempts.text = str("Attempt ", attempt)
