extends Control

@onready var previous_score = $PreviousScoreContainer/Margins/PreviousScore

func _ready() -> void:
	previous_score.text = ""
	update_previous_score()

func open_level(level_name: String) -> void:
	get_tree().change_scene_to_file(str("res://levels/", level_name, ".tscn"))

func update_previous_score() -> void:
	if (GameState.mana == -1) or (GameState.time_remaining == -1):
		previous_score.text = ""
		pass

	var time_player_took = GameState.level_time_limit - GameState.time_remaining
	if time_player_took <= 0:
		time_player_took = -1
	else:
		var score = ceil((GameState.mana ** 2) / time_player_took)
		previous_score.text = str("Previous Score: ", score)


func _on_tutorial_pressed() -> void:
	open_level("tutorial/tutorial")


func _on_easy_pressed() -> void:
	open_level("easy")


func _on_normal_pressed() -> void:
	open_level("normal")


func _on_hard_pressed() -> void:
	open_level("hard")


func _on_quit_pressed() -> void:
	get_tree().quit()
