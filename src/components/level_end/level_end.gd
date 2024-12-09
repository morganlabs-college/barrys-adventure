extends Area2D


func _on_body_entered(body: Node2D) -> void:
	# TODO: Display final stats and a button to go to the next level.
	print("End of level")
	get_tree().paused = true
