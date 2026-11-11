extends Control

@export_file_path() var main_menu_path: String
@onready var morebutton: Button = %morebutton

func _ready() -> void:
	morebutton.pressed.connect(more)

func more():
	get_tree().change_scene_to_file(main_menu_path)
