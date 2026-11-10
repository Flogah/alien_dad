class_name Enemy
extends CharacterBody2D

@onready var interactable: Interactable = $Interactable
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var blood_particles: GPUParticles2D = $BloodParticles
@onready var detection_area: Area2D = %DetectionArea

@export var agent_leader:bool = false
@export var security_pass: SecurityPass

var dead: bool = false

var player:Player

var perceives_player_as_threat:bool = false

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
	move_and_slide()

func move(dir: Vector2) -> void:
	velocity = dir * 10.0

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
