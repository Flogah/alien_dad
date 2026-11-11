extends State

@export var enemy: Enemy

var timer:float

func enter_state(_data: Dictionary = {}) -> void:
	timer = 5.0
	if enemy.sprite:
		enemy.sprite.play("idle")

func physics_update(_delta: float) -> void:
	enemy.velocity = Vector2.ZERO
	timer -= _delta
	if timer < 0.0:
		pace()
	enemy.move_and_slide()

func pace():
	var random_pos:Vector2 = enemy.global_position + Vector2(randi_range(-20, 20), randi_range(-15, 15))
	enemy.nav_agent.target_position = random_pos
	switch_state.emit("walk")
