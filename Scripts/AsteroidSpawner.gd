extends Node2D
#Tiene un timer, cuando acaba el timer spawnea un asteroide en dirección al mapa del nivel
#El timer se reinicia cada vez que acaba, los segundos será el ratio de spawn y es variable pero no mucho, determinado por el numero de nivel
#También tiene un número máximo de asteroides que va a spawnear, determinado por el numero de nivel tambien
#Irá aumentando el numero de spawners con el paso de los niveles, cuando acaben todos finaliza el nivel de forma satisfactoria

@onready var timer : Timer = $Timer
@onready var father : Node2D = $"."
@onready var level : Node2D = $".."

var spawnRatio : float
var maxSpawn   : int

signal asteroidCreated
signal maxSpawnReached

func _ready() -> void:
	timer.start(spawnRatio)
	spawnRatio = Values.spawnRatio
	maxSpawn = Values.level * 2

func _on_timer_timeout() -> void:
	timer.start(spawnRatio)
	spawnAsteroid(Rng.random(1, 4))

func spawnAsteroid(spawnPosition : int) -> void:
	if(maxSpawn > 0):
		var size : int = Rng.random(5, 35)
		var speed : int = 500 #Rng.random(50, 1000)
		var asteroid : Node = preload("res://Scenes/asteroid.tscn").instantiate()
		
		asteroid.Asteroid(size, speed)
		
		if(spawnPosition == 1):
			asteroid.rotation = deg_to_rad(Rng.random(-45, 45))
			asteroid.global_position = Vector2(Rng.random(0, 1920), -291)
			
		elif(spawnPosition == 2):
			asteroid.rotation = deg_to_rad(Rng.random(45, 135))
			asteroid.global_position = Vector2(2222, Rng.random(0, 1080))
			
		elif(spawnPosition == 3):
			asteroid.rotation = deg_to_rad(Rng.random(135, 225))
			asteroid.global_position = Vector2(Rng.random(0, 1920), 1400)
			
		else:
			asteroid.rotation = deg_to_rad(Rng.random(-135, -45))
			asteroid.global_position = Vector2(-300, Rng.random(0, 1080))
			
		father.add_child(asteroid)
		asteroid.asteroidDestroyed.connect(level._on_asteroid_destroyed)
		asteroid.asteroidExploded.connect(level._on_asteroid_exploded)
		
		maxSpawn -= 1
		asteroidCreated.emit()
		if(maxSpawn <= 0): maxSpawnReached.emit()
