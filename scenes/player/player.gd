extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var interaction_area: Area2D = $InteractionArea

var speed:float = 25.0

var last_dir: Vector2 = Vector2.ZERO:
	set(new_val):
		#var old_val = last_dir
		last_dir = new_val
		#if old_val != new_val: print(new_val)

func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, 200)
		velocity.y = move_toward(velocity.y, 0, 200)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_down"):
		last_dir = Vector2.DOWN
	if event.is_action_pressed("move_up"):
		last_dir = Vector2.UP
	if event.is_action_pressed("move_left"):
		last_dir = Vector2.LEFT
		sprite.flip_h = false
	if event.is_action_pressed("move_right"):
		last_dir = Vector2.RIGHT
		sprite.flip_h = true
	
	if event.is_action_pressed("interact"):
		try_interact()

func try_interact():
	var overlapping_areas = interaction_area.get_overlapping_areas()
	if !overlapping_areas:
		return
	for area: Interactable in overlapping_areas:
		area.interact(self)
