class_name SecurityCode
extends Resource

enum sec_level{
	low_sec,
	mid_sec,
	hi_sec,
	top_sec
}

@export var holder: String = &""
@export var level: sec_level
