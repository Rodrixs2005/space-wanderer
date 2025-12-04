extends Area2D

@onready var sprite : Sprite2D = $Sprite2D

var type : int

const TEXTURES : Array[Texture2D] = [
	preload("res://Sprites/Loot/Loot1.png"),
	preload("res://Sprites/Loot/Loot2.png"),
	preload("res://Sprites/Loot/Loot3.png")
]

func _ready() -> void:
	type = Rng.random(0 , 2)
	sprite.texture = TEXTURES[type]
	

func _on_area_entered(area: Area2D) -> void:
	if(!area.is_in_group("Asteroids")):
		if(type == 0):
			Values.blueMat += 10
			
		elif(type == 1):
			Values.greenMat += 10
			
		elif(type == 2):
			Values.orangeMat += 10
			
		
		queue_free()
