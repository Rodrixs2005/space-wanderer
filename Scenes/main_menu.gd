extends Control

@onready var play : Button = $VBoxContainer/Play
@onready var quit : Button = $VBoxContainer/Quit



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/intro.tscn")
	
	


func _on_quit_pressed() -> void:
	get_tree().quit()
