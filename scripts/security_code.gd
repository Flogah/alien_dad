class_name SecurityCode
extends Resource

enum sec_level{
	low_sec,
	mid_sec,
	hi_sec,
	top_sec
}

static var security_color: Dictionary[sec_level, Color] = {
	sec_level.low_sec: Color.WEB_GRAY,
	sec_level.mid_sec: Color.DARK_OLIVE_GREEN,
	sec_level.hi_sec: Color.NAVY_BLUE,
	sec_level.top_sec: Color.DARK_RED,
}

@export var level: sec_level

func get_security_color(level: sec_level) -> Color:
	return security_color.get(level)
