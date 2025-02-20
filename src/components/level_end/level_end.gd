extends Area2D


func _on_body_entered(body: Node2D) -> void:
	GameState.mana = body.mana
	get_tree().change_scene_to_file("res:///screens/main_menu/main_menu.tscn")
