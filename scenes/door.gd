extends StaticBody2D

@onready var interactable: Interactable = $Interactable
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var door: CollisionShape2D = $Door

var locked: bool = false
var closed: bool = true

func _ready() -> void:
	interactable.interacted.connect(on_interacted)

func on_interacted(actor):
	if closed:
		closed = false
		open()
	else:
		closed = true
		close()

func open():
	sprite.play("open")
	door.disabled = true

func close():
	sprite.play("closed")
	door.disabled = false
