class_name PlayerUI
extends CanvasLayer

@onready var bg_col: ColorRect = %BGCol
@onready var headshot_sprite: AnimatedSprite2D = %HeadshotSprite
@onready var name_label: Label = %NameLabel
@onready var access_label: Label = %AccessLabel

@export var security_id: SecurityPass:
	set(new_id):
		security_id = new_id
		update_id()

func update_id():
	headshot_sprite.sprite_frames = security_id.sprite
	name_label.text = security_id.holder
	if security_id.level > 0:
		access_label.text = 'Access Level: ' + str(security_id.level)
	else:
		access_label.text = 'Security Threat'
	bg_col.color = security_id.get_security_color(security_id.level)
