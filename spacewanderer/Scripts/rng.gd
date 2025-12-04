extends Node

@onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func random(minV : int, maxV : int) -> int:
	rng.randomize()
	return rng.randi_range(minV, maxV)
