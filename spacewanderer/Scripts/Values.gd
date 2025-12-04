extends Node

#Valores de una nave
var MAX_SPEED : int = 750
var rotationSpeed :int = 250 
var defSpeed : int = 50
var gas : int = 5000
var ammo : int = 1000
var maxAmmo : int = 10
var maxGas : int = 500

var engineState : float = 1000000
var cannonState : float = 100
var tankState : float = 100

var engineDurability : int = 1000000
var cannonDurability : int = 100
var tankDurability : int = 100

const maxEngine : int = 100
const maxCannon : int = 100
const maxTank : int = 100

var shielEnabled : bool = false
var superShootEnabled : bool = false
var tpEnabled : bool = false
	  
#Valores de una Bala
var speed  : int = 1000

#Nivel
var level : int = 1
 
#Valores del spawner de asteroides
var spawnRatio : float = max(0.5, 3.0 - 0.1 * (level - 1))

#Money
var orangeMat : int = 0
var blueMat : int = 0
var greenMat : int = 0
