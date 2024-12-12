extends Area2D


func _on_body_entered(body):
	body.add_mana()
	queue_free()  # Remove the coin Scene from game
