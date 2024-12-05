extends Node2D


func _process(_delta: float) -> void:
	if !get_tree().paused:
		hide()
	else:
		show()
