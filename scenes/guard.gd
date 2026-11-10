class_name Enemy
extends CharacterBody2D

@onready var interactable: Interactable = $Interactable
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var blood_particles: GPUParticles2D = $BloodParticles
@onready var detection_area: Area2D = %DetectionArea
@onready var nav_agent: NavigationAgent2D = %NavigationAgent2D

@export var agent_leader:bool = false
@export var security_pass: SecurityPass

var dead: bool = false

var player:Player

var perceives_player_as_threat:bool = false
var target

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
	
	interactable.interacted.connect(on_interacted)

func _physics_process(_delta: float) -> void:
	var next_path_position = nav_agent.get_next_path_position()
	var new_vel = (next_path_position - global_position).normalized()
	velocity = new_vel * 10
	move_and_slide()
	
	if velocity.is_equal_approx(Vector2.ZERO):
		sprite.play("walk")
	else:
		sprite.play("idle")

func set_target_pos(pos: Vector2) -> void:
	nav_agent.target_position = pos

func on_interacted(actor, sec_acc):
	if dead:
		return
	if actor is Player:
		actor.assume_skin(security_pass)
	die()

func die():
	sprite.hide()
	blood_particles.emitting = true
	dead = true
	collision_layer = 0
	collision_mask = 0

func detect_player():
	if !player:
		var bodies = detection_area.get_overlapping_bodies()
		for body in bodies:
			if body is Player:
				player = body
	else:
		var p_id:SecurityPass = player.check_id()
		if p_id.level == 0:
			perceives_player_as_threat = true

func get_id() -> SecurityPass:
	return security_pass
