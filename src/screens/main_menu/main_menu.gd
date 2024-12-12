extends Control


func open_level(level_name: String) -> void:
	get_tree().change_scene_to_file(str("res://levels/", level_name, ".tscn"))


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
