class_name Enemy
extends CharacterBody2D

@onready var interactable: Interactable = $Interactable
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var blood_particles: GPUParticles2D = $BloodParticles
@onready var detection_area: Area2D = %DetectionArea
@onready var nav_agent: NavigationAgent2D = %NavigationAgent2D
@onready var vision_raycast: RayCast2D = %VisionRaycast
@onready var state_machine: StateMachine = %StateMachine
@onready var vision_cone: Sprite2D = %VisionCone
@onready var lose_area: Area2D = %LoseArea

@export var agent_leader:bool = false
@export var security_pass: SecurityPass

var dead: bool = false

var player:Player
var sees_player:bool = false:
	set(new_val):
		if sees_player != new_val:
			sees_player = new_val
var perceives_player_as_threat:bool = false:
	set(new_val):
		if perceives_player_as_threat != new_val:
			perceives_player_as_threat = new_val
			if perceives_player_as_threat:
				state_machine.active_state.switch_state.emit("attack_walk")

var last_move_direction:Vector2 = Vector2.RIGHT

func _ready() -> void:
	if !security_pass:
		security_pass = SecurityPass.new()
		if agent_leader:
			security_pass.level = SecurityCode.sec_level.hi_sec
		else:
			security_pass.level = SecurityCode.sec_level.low_sec
	if !security_pass.sprite:
		security_pass.sprite = CharacterGenerator.random_spriteframes()
	sprite.sprite_frames = security_pass.sprite
	if security_pass.holder.is_empty():
		security_pass.holder = CharacterGenerator.random_first_last_name()
	
	lose_area.body_exited.connect(lose_player)
	detection_area.body_entered.connect(find_player)
	interactable.interacted.connect(on_interacted)

func _physics_process(delta: float) -> void:
	if player:
		detect_player()
	if sees_player and !perceives_player_as_threat:
		check_player_id()
	
	print(last_move_direction)
	vision_cone.rotation = last_move_direction.angle() - deg_to_rad(45.0)
	print(state_machine.active_state.name)
	
	var vel:Vector2 = velocity.normalized()
	if vel.x < 0.0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	

func on_interacted(actor, sec_acc):
	if dead:
		return
	if actor is Player:
		actor.assume_skin(security_pass)
	die()

func find_player(body):
	if body is Player and !player:
		player = body
		player.eating.connect(func(): perceives_player_as_threat = true)

func lose_player(body):
	if body is Player and player:
		sees_player = false
		perceives_player_as_threat = false
		player.eating.disconnect(func(): perceives_player_as_threat = true)
		player = null

func die():
	sprite.hide()
	detection_area.monitoring = false
	vision_raycast.enabled = false
	blood_particles.emitting = true
	dead = true
	player = null
	vision_cone.hide()
	collision_layer = 0
	collision_mask = 0
	state_machine.active_state.switch_state.emit("dead")

func detect_player():
	var player_position = player.global_position - global_position
	vision_raycast.target_position = player_position
	var dot:float = player_position.normalized().dot(last_move_direction)
	if vision_raycast.is_colliding() and dot > -0.5 and dot < 0.5:
		var collider = vision_raycast.get_collider()
		if collider is Player:
			sees_player = true
		else:
			sees_player = false
			perceives_player_as_threat = false
			player.eating.disconnect(func(): perceives_player_as_threat = true)
			player = null

func check_player_id():
	var p_id:SecurityPass = player.get_id()
	if p_id.level == 0 and !perceives_player_as_threat:
		perceives_player_as_threat = true
		print("OH NO")
	elif p_id.level > security_pass.level and !perceives_player_as_threat:
		print("Good morning, sir!")

func get_id() -> SecurityPass:
	return security_pass
