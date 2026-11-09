extends StaticBody2D

@onready var interactable: Interactable = $Interactable

func _ready() -> void:
	interactable.interacted.connect(on_interacted)

func on_interacted(actor):
	print("Interaced with by: " + actor.name)
