extends StaticBody2D

@export var security_level: SecurityCode
@export var locked: bool = false

@onready var interactable: Interactable = $Interactable
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var door: CollisionShape2D = $Door

var closed: bool = true

func _ready() -> void:
	interactable.interacted.connect(on_interacted)
	update_sprite()

func on_interacted(actor, sec_acc:SecurityCode):
	if locked:
		if sec_acc.level >= security_level.level:
			Exclamator.exclaim("Access granted", global_position)
			locked = false
			update_sprite()
			return
		else:
			Exclamator.exclaim("Higher access needed", global_position)
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
