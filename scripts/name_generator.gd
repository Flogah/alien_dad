extends Node

var FILES = {
  'first' : "res://scripts/name_list/first.txt",
  'last' : "res://scripts/name_list/last.txt"
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
