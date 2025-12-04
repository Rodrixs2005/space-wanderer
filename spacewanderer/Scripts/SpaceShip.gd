extends CharacterBody2D

@onready var bullets = $Bullets #El padre de las balas, ahí se van a estanciar

#Atributos de la nave
var MAX_SPEED : int
var rotationSpeed :int
var defSpeed : int
var speed : int
var gas : int
var ammo : int
var shieldActivated : bool = false

signal asteroidDestroyedByShield

func _ready() -> void:
	MAX_SPEED = Values.MAX_SPEED 
	rotationSpeed = Values.rotationSpeed 
	defSpeed = Values.defSpeed
	speed = defSpeed
	gas = Values.gas
	ammo = Values.ammo

func _physics_process(delta) -> void:
	movement(delta)
	shoot()
	
	if(Input.is_action_pressed("Shield")):
		activateShield()
		
	if(Input.is_action_just_pressed("SuperShoot")):
		superShoot()

	if(Input.is_action_just_pressed("TP")):
		tp()
	
	if(position.x > 1920):
		position.x = 0
	if(position.x < 0):
		position.x = 1920
	if(position.y < 0):
		position.y = 1080
	if(position.y > 1080):
		position.y = 0
		
	#Mientras aceleramos se va gastando la gasolina
	if(Input.is_action_pressed("Accelerate")):
		gas -= 1

#ESTA FUNCIÓN SE ENCARGA DEL MOVIMIENTO DE LA NAVE
func movement(delta) -> void:
	var inputVector = Vector2(0, ((int)(Input.is_action_pressed("Accelerate")) * (-1)))
	
	var engineReduction : float = Values.MAX_SPEED/Values.engineDurability
	Values.engineState -= engineReduction
	
	if(Values.engineState > 0):
		velocity += inputVector.rotated(rotation) * speed #Así si le das para arriba va hacia donde apunta la nave
		velocity = velocity.limit_length(MAX_SPEED) #Así se limita la velocidad
	
	#Si nos quedamos sin gasolina no nos podremos mover
	if(gas <= 0):
		speed = 0
		gas = 0 #Para que no sea negativo y al subir subamos desde 0
	else:
		speed = defSpeed
	
	
	if(Input.is_action_pressed("RotateRight")):
		rotate(deg_to_rad(rotationSpeed * delta))
		
	if(Input.is_action_pressed("RotateLeft")):
		rotate(deg_to_rad(-rotationSpeed * delta))
	
	
	velocity = velocity.move_toward(Vector2.ZERO, 5) #Fricción
	move_and_slide() 

#ESTA FUNCIÓN SE ENCARGA DE CONTROLAR LA INSTANCIACIÓN DE LAS BALAS EN LA ESCENA DEL JUEGO
func shoot() -> void:
	if(ammo >= 1 && Values.cannonState >= 1):
		if(Input.is_action_just_pressed("Shoot")):
			var loadBullets = preload("res://Scenes/bullets.tscn") #Se carga la escena
			var bulletScene =  loadBullets.instantiate() #Se crea la instancia
			
			#Se iguala posición y rotación para que cuando spawnee la bala salga desde la nave hacia donde apunte
			bulletScene.global_position = global_position
			bulletScene.rotation = rotation
			
			bullets.add_child(bulletScene) #Se meten todas en el padre para que no haya conflictos con los demás nodos
			
			ammo -=1
			Values.cannonState -= Values.maxCannon/Values.cannonDurability


func _on_area_2d_area_entered(area):
	if(area.is_in_group("Asteroids")):
		if(shieldActivated):
			area.queue_free()
			shieldActivated = false
			asteroidDestroyedByShield.emit()
		else:
			get_tree().quit()


func _on_level_ending_level() -> void:
	Values.MAX_SPEED = MAX_SPEED 
	Values.rotationSpeed = rotationSpeed 
	Values.defSpeed = defSpeed
	Values.gas = gas
	Values.ammo = ammo

func tp():
	if(Values.tpEnabled):
		var direccion : Vector2 = Vector2.UP.rotated(rotation)
		global_position += direccion * 500
		Values.tpEnabled = false
#		velocity = Vector2(0, 0) no sé si meter esto o no


func activateShield():
	if(Values.shielEnabled):
		shieldActivated = true
		Values.shielEnabled = false

func superShoot():
	if(Values.superShootEnabled):
		var n = 16  # número de balas
		var angle_step = TAU / n  # TAU = 2 * PI
		var bullet_scene = preload("res://Scenes/bullets.tscn")
		
		for i in range(n):
			var bullet = bullet_scene.instantiate()
			
			bullet.global_position = global_position  # la nave dispara desde su posición
			bullet.rotation = i * angle_step  # cada bala apunta a un ángulo distinto
			
			bullets.add_child(bullet)  # donde bullets es el nodo contenedor
		
		Values.superShootEnabled = false
