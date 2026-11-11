extends Control

@onready var babybutton: Button = %babybutton
@onready var nobutton: Button = %nobutton

@export_file_path() var start_scene_path: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nobutton.pressed.connect(func(): get_tree().quit())
	babybutton.pressed.connect(func(): get_tree().change_scene_to_file(start_scene_path))
	
