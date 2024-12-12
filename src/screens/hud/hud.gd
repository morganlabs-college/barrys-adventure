extends CanvasLayer

@onready var attempts := $GameInfoContainer/Margins/GameInfo/AttemptsCounter
@onready var score := $GameInfoContainer/Margins/GameInfo/ManaCounter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score(0)
	update_attempts()


func update_score(mana: int) -> void:
	score.text = str("Mana: ", mana)


func update_attempts() -> void:
	attempts.text = str("Attempt ")
