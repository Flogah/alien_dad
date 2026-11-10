extends State

@export var enemy: Enemy

var timer:float

func physics_update(_delta: float) -> void:
	timer -= _delta
	if timer < 0.0:
		pace()

func pace():
	
	enemy.move(Vector2.DOWN.rotated(randf_range(-PI, PI)))
	timer = randf_range(0.5, 0.7)
