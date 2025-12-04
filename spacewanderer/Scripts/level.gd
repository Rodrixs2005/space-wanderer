extends Node2D

var asteroidsCNT : int = 0
var noMoreAsteroids : bool = false

signal endingLevel

func _ready() -> void:
	Values.level += 1

func _on_asteroid_destroyed() -> void:
	asteroidsCNT -= 1
	if(asteroidsCNT <= 0): 
		endLevel()

func _on_asteroid_exploded() -> void:
	asteroidsCNT += 2

func _on_asteroid_created() -> void:
	asteroidsCNT += 1

func _on_max_spawn_reached() -> void:
	noMoreAsteroids = true

func endLevel() -> void:
	if(noMoreAsteroids):
		endingLevel.emit()
		call_deferred("_go_to_upgrading_zone")

func _go_to_upgrading_zone():
	get_tree().change_scene_to_file("res://Scenes/upgrading_zone.tscn")

func _on_space_ship_asteroid_destroyed_by_shield() -> void:
	asteroidsCNT -= 1
	if(asteroidsCNT <= 0): 
		endLevel()
