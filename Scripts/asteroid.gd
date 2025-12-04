extends Area2D

@onready var father : Node2D = $".."
@onready var level : Node2D = $"../.."

#ATRIBUTOS DE UN ASTEROIDE
var size : int = 1
var speed : int = 0
const SPRITES : Array[Texture2D] = [
	preload("res://Sprites/Asteroids/Asteroid_2.png"),
	preload("res://Sprites/Asteroids/Asteroid_4.png"),
	preload("res://Sprites/Asteroids/Asteroid_8.png"),
	preload("res://Sprites/Asteroids/Asteroid_16.png"),
	preload("res://Sprites/Asteroids/Asteroid_32.png"),
	preload("res://Sprites/Asteroids/Asteroid_64.png")
]
var initialized : bool = false

signal asteroidDestroyed
signal asteroidExploded

func _physics_process(delta: float) -> void:
	global_position += Vector2(0, 1).rotated(rotation) * speed * delta

func _ready() -> void:
	if !initialized :
		assert(false, "Hay que usar el constructor de asteroides, bobo, espabila, la de programar no te la sabes crack")
	var index: int = clamp(int((size - 10) / 5), 0, SPRITES.size() - 1)
	
	$Sprite2D.texture = SPRITES[index]
	scale.x = size
	scale.y = size

#LLAMAR A ESTA FUNCION SIEMPRE QUE SE INSTANCIE ESTE OBJETO, ES EL CONSTRUCTOR
func Asteroid(sz, sp) -> void:
	size = sz
	speed = sp
	initialized = true

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Border"): 
		asteroidDestroyed.emit()
		queue_free()
	
	elif area.is_in_group("Bullets"):
		area.queue_free()
		
		if size > 10 :
			var asteroid1 : Node = preload("res://Scenes/asteroid.tscn").instantiate()
			var asteroid2 : Node = preload("res://Scenes/asteroid.tscn").instantiate()
			explode(asteroid1, 1)
			explode(asteroid2, -1)
			asteroidExploded.emit()
			
			if(Rng.random(1, 10) > 5):
				dropLoot()
			
		queue_free()
		asteroidDestroyed.emit()

func explode(asteroid : Node, cte : int):
	
	asteroid.rotation = deg_to_rad(Rng.random(0, 360))
	asteroid.global_position = global_position + Vector2(Rng.random(1, 50), Rng.random(1,50)) * cte
	asteroid.Asteroid(size-5, speed-10)
	
	father.call_deferred("add_child", asteroid)
	
	asteroid.asteroidDestroyed.connect(level._on_asteroid_destroyed)
	asteroid.asteroidExploded.connect(level._on_asteroid_exploded)
	

func dropLoot():
	var loot : Node2D = preload("res://Scenes/loot.tscn").instantiate()
	
	loot.global_position = global_position
	father.call_deferred("add_child", loot)
