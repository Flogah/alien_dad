extends StaticBody2D

@export var security_level: SecurityCode
@export var locked: bool = false

@onready var interactable: Interactable = $Interactable
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var door: CollisionShape2D = $Door
@onready var access_granted: AudioStreamPlayer2D = $Access_granted
@onready var access_denied: AudioStreamPlayer2D = $Access_denied

var closed: bool = true

func _ready() -> void:
	interactable.interacted.connect(on_interacted)
	update_sprite()

func on_interacted(actor, sec_acc:SecurityCode):
	if locked:
		if sec_acc.level >= security_level.level:
			Exclamator.exclaim("GRANTED", global_position, security_level.get_security_color(security_level.level))
			locked = false
			update_sprite()
			access_granted.play()
			return
		else:
			Exclamator.exclaim("DENIED", global_position, security_level.get_security_color(security_level.level))
			access_denied.play()
			return
	if closed:
		open()
	else:
		close()

func open():
	closed = false
	door.disabled = true
	update_sprite()

func close():
	closed = true
	door.disabled = false
	update_sprite()

func update_sprite():
	if locked:
		sprite.play("locked")
	elif closed:
		sprite.play("closed")
	else:
		sprite.play("open")
