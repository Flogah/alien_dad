extends CharacterBody2D

@onready var interactable: Interactable = $Interactable
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var blood_particles: GPUParticles2D = $BloodParticles

@export var security_access: SecurityCode
@export var spriteframes: SpriteFrames

var dead: bool = false

func _ready() -> void:
	if !security_access:
		security_access = SecurityCode.new()
	if spriteframes:
		sprite.sprite_frames = spriteframes
	else:
		sprite.sprite_frames = CharacterGenerator.random_spriteframes()
	if security_access.holder.is_empty():
		security_access.holder = CharacterGenerator.random_first_last_name()
	
	interactable.interacted.connect(on_interacted)

func on_interacted(actor, sec_acc):
	if dead:
		return
	if actor is Player:
		print("Take my skin, good sir")
		actor.assume_skin(sprite.sprite_frames, security_access)
	die()

func die():
	sprite.hide()
	blood_particles.emitting = true
	dead = true
	collision_layer = 0
	collision_mask = 0
