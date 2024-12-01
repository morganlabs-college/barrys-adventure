extends Area2D

@export var input_to_unfreeze := ""


func _on_body_entered(_body: Node2D) -> void:
	get_tree().paused = true


func _input(event) -> void:
	if !get_tree().paused:
		return

	if event.is_action_pressed(input_to_unfreeze):
		get_tree().paused = false
