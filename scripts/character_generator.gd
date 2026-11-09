extends Node

var FILES = {
  'first' : "res://scripts/name_list/first.txt",
  'last' : "res://scripts/name_list/last.txt"
}

var npc_characters = {
	'black' : "res://assets/sprites/sprite_frames/black_suit_spriteframes.tres",
	'blue' : "res://assets/sprites/sprite_frames/blue_suit_spriteframes.tres",
	'grey' : "res://assets/sprites/sprite_frames/grey_suit_spritesframes.tres",
}

func random_first_last_name() -> String:
	var full_name: String = ''
	full_name += random_item(FILES['first'])
	full_name += ' '
	full_name += random_item(FILES['last'])
	return full_name

func random_item(file: String):
	var list = FileAccess.open(file, FileAccess.READ)
	var item_amount: int = get_line_amount(file)
	var rand = randi_range(0, item_amount)
	
	for i in rand -1:
		list.get_line()
	return list.get_line()

func get_line_amount(file: String) -> int:
	var list = FileAccess.open(file, FileAccess.READ)
	var lines: int = 0
	while not list.eof_reached():
		lines += 1
		list.get_line()
	return lines

func random_spriteframes() -> SpriteFrames:
	var size = npc_characters.size()
	var rand = npc_characters.keys()[randi_range(0,size-1)]
	var path = npc_characters[rand]
	var frames = load(path)
	return frames
