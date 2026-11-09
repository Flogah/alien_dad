class_name Interactable
extends Area2D

signal interacted(actor, sec_acc)

func interact(actor, sec_acc):
	interacted.emit(actor, sec_acc)
