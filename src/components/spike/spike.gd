extends Node2D

@onready var sprite = $AnimatedSprite2D


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	sprite.play("rise")
