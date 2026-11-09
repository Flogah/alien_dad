class_name Interactable
extends Area2D

signal interacted(actor)

func interact(actor):
	interacted.emit(actor)
