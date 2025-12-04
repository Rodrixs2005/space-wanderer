extends Control

@onready var timer : Timer = $Timer
@onready var bulletCap : Button = $BulletCapacity
@onready var acc : Button = $Acceleration
@onready var agility : Button = $Agility
@onready var bullets : Button = $Bullets
@onready var gasCapacity : Button = $GasCapacity
@onready var gas : Button = $Gas
@onready var engine : Button = $Engine
@onready var cannon : Button = $Cannon
@onready var tank : Button = $Tank

func _ready() -> void:
	timer.start(10)


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/level.tscn")


func _on_bullet_capacity_pressed() -> void:
	if(Values.greenMat >= 10):
		Values.maxAmmo += 10
	else:
		print("Necesitas más materiales")


func _on_acceleration_pressed() -> void:
	if(Values.greenMat >= 10):
		Values.defSpeed += 10
	else:
		print("Necesitas más materiales")


func _on_agility_pressed() -> void:
	if(Values.blueMat >= 10):
		Values.rotationSpeed += 10
	else:
		print("Necesitas más materiales")

func _on_bullets_pressed() -> void:
	if(Values.blueMat >= 10):
		if(Values.ammo <= Values.maxAmmo - 10):
			Values.ammo += 10
		else:
			Values.ammo = Values.maxAmmo
	else:
		print("Necesitas más materiales")

func _on_gas_pressed() -> void:
	if(Values.blueMat >= 10):
		if(Values.gas <= Values.maxGas - 100):
			Values.gas += 100
		else:
			Values.gas = Values.maxGas
			Values.tankState -= Values.maxTank/Values.tankDurability
	else:
		print("Necesitas más materiales")

func _on_gas_capacity_pressed() -> void:
	if(Values.greenMat >= 10):
		Values.maxGas += 100
	else:
		print("Necesitas más materiales")

func _on_engine_pressed() -> void:
	if(Values.orangeMat >= 10):
		if(Values.engineState < Values.maxEngine):
			Values.engineState += 10
		else:
			Values.engineState = Values.maxEngine
			Values.engineDurability += 10
	else:
		print("Necesitas más materiales")


func _on_cannon_pressed() -> void:
	if(Values.orangeMat >= 10):
		if(Values.cannonState < Values.maxCannon):
			Values.cannonState += 10
		else:
			Values.cannonState = Values.maxCannon
			Values.cannonDurability += 10
	else:
		print("Necesitas más materiales")


func _on_tank_pressed() -> void:
	if(Values.orangeMat >= 10):
		if(Values.tankState < Values.maxTank):
			Values.tankState += 10
		else:
			Values.tankState = Values.maxTank
			Values.tankDurability += 10
	else:
		print("Necesitas más materiales")

func _on_durability_super_pressed() -> void:
	if(Values.blueMat >= 10 && Values.greenMat >= 10 && Values.greenMat >= 10):
		Values.shielEnabled = true
	else:
		print("Necesitas más materiales")

func _on_shooting_super_pressed() -> void:
	if(Values.blueMat >= 10 && Values.greenMat >= 10 && Values.greenMat >= 10):
		Values.superShootEnabled = true
	else:
		print("Necesitas más materiales")

func _on_movility_super_pressed() -> void:
	if(Values.blueMat >= 10 && Values.greenMat >= 10 && Values.greenMat >= 10):
		Values.tpEnabled = true
	else:
		print("Necesitas más materiales")
