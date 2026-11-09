class_name Player
extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var interaction_area: Area2D = $InteractionArea

@export var speed:float = 25.0
@export var security_access: SecurityCode

@export var original_skin: SpriteFrames

var reverse: bool = false

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
		if reverse:
			sprite.play("walk_up")
		else:
			sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, 200)
		velocity.y = move_toward(velocity.y, 0, 200)
		if reverse:
			sprite.play("idle_up")
		else:
			sprite.play("idle")

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_down"):
		last_dir = Vector2.DOWN
		reverse = false
	if event.is_action_pressed("move_up"):
		last_dir = Vector2.UP
		reverse = true
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
	
	var closest_area: Interactable = overlapping_areas[0]
	for area: Interactable in overlapping_areas:
		if global_position.distance_squared_to(closest_area.global_position) > global_position.distance_squared_to(area.global_position):
			closest_area = area
	
	closest_area.interact(self, security_access)
		
func assume_skin(new_skin: SpriteFrames, new_acc: SecurityCode):
	sprite.sprite_frames = new_skin
	security_access = new_acc
	#if new_acc.level > security_access.level:
		#security_access = new_acc

func lose_skin():
	sprite.sprite_frames = original_skin
