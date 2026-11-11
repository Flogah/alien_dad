extends State

@export var enemy: Enemy
var timer:float

func enter_state(_data: Dictionary = {}) -> void:
	timer = randf_range(1.0, 2.0)
	enemy.sprite.play("walk")
	enemy.nav_agent.target_reached.connect(on_target_reached)

func physics_update(_delta: float) -> void:
	
	var next_path_position = enemy.nav_agent.get_next_path_position()
	var new_vel = (next_path_position - enemy.global_position).normalized()
	enemy.velocity = new_vel * 5
	enemy.last_move_direction = new_vel.normalized()
	enemy.move_and_slide()
	
	timer -= _delta
	if timer < 0.0:
		on_target_reached()

func on_target_reached():
	switch_state.emit("idle")

func exit_state() -> void:
	enemy.nav_agent.target_reached.disconnect(on_target_reached)
