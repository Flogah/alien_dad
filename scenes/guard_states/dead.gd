extends State

@export var enemy: Enemy

var timeout_timer:float = 5.0

func enter_state(_data: Dictionary = {}) -> void:
	enemy.velocity = Vector2.ZERO

func physics_update(_delta: float) -> void:
	if timeout_timer > 0.0:
		timeout_timer -= _delta
		enemy.move_and_slide()
