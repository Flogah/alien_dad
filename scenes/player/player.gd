extends CharacterBody2D


var speed:float = 25.0


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, 200)
		velocity.y = move_toward(velocity.y, 0, 200)

	move_and_slide()
