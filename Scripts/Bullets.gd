extends Area2D

@onready var timer = $Timer

var vector : Vector2 = Vector2(0, -1) #Input vector
var speed  : int

func _ready() -> void:
	timer.start(1)
	speed = Values.speed
	
func _physics_process(delta) -> void:
		global_position += vector.rotated(rotation) * speed * delta #Así la bala sale en dirección hacia donde está girada

func _on_timer_timeout() -> void:
	queue_free()
