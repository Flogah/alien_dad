extends Node2D

const STANDARD_THEME = preload("uid://cj0kowg8s0uu4")

var label_timing_dict:Dictionary [Label, Vector2] = {}

func _process(delta: float) -> void:
	update_times(delta)

func update_times(delta):
	if label_timing_dict.is_empty():
		return
	for label in label_timing_dict:
		label_timing_dict[label].x += delta
		if label_timing_dict[label].x >= label_timing_dict[label].y:
			label_timing_dict.erase(label)
			label.queue_free()

func exclaim(text: String, pos: Vector2, time: float = 1.0):
	var new_label = create_text(text)
	add_child(new_label)
	new_label.position = pos + Vector2(0, -14)
	label_timing_dict[new_label] = Vector2(0.0, time)

func create_text(text: String) -> Label:
	var label:Label = Label.new()
	label.theme = STANDARD_THEME
	label.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
	label.text = text
	label.z_index = 99
	label.scale = Vector2.ONE * 0.2
	return label
