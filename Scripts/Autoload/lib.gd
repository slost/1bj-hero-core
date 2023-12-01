## Library สำหรับเก็บฟังชันก์ที่ใช้งานบ่อย ๆ
extends Node

# สมการคำนวณความเร็วสำหรับ CharactorBody2D
func get_character_speed(_distance: int, _scale:Vector2) -> float:
	var character_size = _distance * _scale.x
	var tile_size = Global.TILE_SIZE * Global.SCALE
	return character_size * tile_size
	

func bars_to_seconds(_bars: Array, _tempo: float) -> float:
	var seconds_per_bar = get_seconds_per_bar(_tempo)
	var seconds = 0
	seconds += seconds_per_bar * _bars[0]
	seconds += seconds_per_bar / 2 * _bars[1]
	seconds += seconds_per_bar / 4 * _bars[2]
	return seconds

func int_to_vector2(_int: int) -> Vector2:
	return Vector2(_int, _int)

func get_direction(_direction: String):
	var direction: Vector2
	match _direction:
		"nw":
			direction = -Vector2.ONE 
		"n":
			direction = Vector2.UP
		"ne":
			direction = Vector2(1,-1)
		"w":
			direction = Vector2.LEFT
		"mid":
			direction = Vector2.ZERO
		"e":
			direction = Vector2.RIGHT
		"sw":
			direction = Vector2(-1,1)
		"s":
			direction = Vector2.DOWN
		"se":
			direction = Vector2.ONE
		_:
			return null	
	return direction
			
func get_seconds_per_bar(_tempo: float) -> float:
	return 60.0 / _tempo


func fix_bars(_bars: Array) -> Array:
	var first = _bars[0]
	var second = _bars[1]
	var third = _bars[2]
	if _bars[2] > 4:
		third = 1
		second += 1
	if second > 4:
		second = 1
		first += 1
	return [first, second, third]	


# รีเทิร์นข้อมูลแพทเทิร์นออกมาเป็นดิคชันนารีที่รวมค่าในแต่ละเลเยอร์เอาไว้
func get_pattern_data(_pattern) -> Dictionary:
	var pattern_data: Dictionary = {}
	# วนลูปในแต่ละเลเยอร์เพื่อเพิ่มเข้ารีเทิร์น
	for layer in _pattern.get_layers_count():
		var layer_name: String = _pattern.get_layer_name(layer)
		var layer_data: Array = []
		for cell in _pattern.get_used_cells(layer):
			var tile: Dictionary = {}
			tile["position"] = Vector2(cell.x, cell.y)
			var cell_data: TileData = _pattern.get_cell_tile_data(layer, cell)
			if cell_data:
				var direction = cell_data.get_custom_data("direction")
				if direction:
					tile["direction"] = direction
			layer_data.append(tile)
		pattern_data[layer_name] = layer_data
	return pattern_data


func get_bars_string(_bars: Array) -> String:
	return str(_bars[0]) + ":" + str(_bars[1]) + ":" + str(_bars[2]) # + ":" + str(_bars[3]) 