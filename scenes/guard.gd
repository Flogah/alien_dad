extends CharacterBody2D

@onready var interactable: Interactable = $Interactable
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var blood_particles: GPUParticles2D = $BloodParticles

@export var security_pass: SecurityPass

var dead: bool = false

func _ready() -> void:
	if !security_pass:
		security_pass = SecurityPass.new()
		security_pass.level = SecurityCode.sec_level.mid_sec
	if !security_pass.sprite:
		security_pass.sprite = CharacterGenerator.random_spriteframes()
	sprite.sprite_frames = security_pass.sprite
	if security_pass.holder.is_empty():
		security_pass.holder = CharacterGenerator.random_first_last_name()
	
	interactable.interacted.connect(on_interacted)

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
