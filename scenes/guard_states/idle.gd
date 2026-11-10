extends State

@export var enemy: Enemy

var timer:float

func physics_update(_delta: float) -> void:
	timer -= _delta
	if timer < 0.0:
		pace()

func pace():
	var random_pos:Vector2 = enemy.global_position + Vector2(randi_range(-15, 15), randi_range(-15, 15))
	enemy.set_target_pos(random_pos)
	timer = randf_range(3, 5)
