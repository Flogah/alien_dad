extends State

@export var enemy: Enemy

func enter_state(_data: Dictionary = {}) -> void:
	enemy.sprite.play("walk")
	enemy.nav_agent.target_reached.connect(on_target_reached)

func physics_update(_delta: float) -> void:
	var next_path_position = enemy.nav_agent.get_next_path_position()
	var new_vel = (next_path_position - enemy.global_position).normalized()
	enemy.velocity = new_vel * 5
	enemy.last_move_direction = new_vel.normalized()
	enemy.move_and_slide()

func on_target_reached():
	switch_state.emit("idle")

func exit_state() -> void:
	enemy.nav_agent.target_reached.disconnect(on_target_reached)
