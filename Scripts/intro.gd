extends Node2D

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animation.play("Cinema")


func _on_animated_sprite_2d_animation_finished() -> void:
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
