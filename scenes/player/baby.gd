extends Node2D

@onready var interactable: Interactable = %Interactable

@export_file_path() var win_screen_path: String

func _ready() -> void:
	interactable.interacted.connect(win)

func win(actor, sec_acc):
	get_tree().change_scene_to_file(win_screen_path)
