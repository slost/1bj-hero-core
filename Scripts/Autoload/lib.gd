## Library สำหรับเก็บฟังชันก์ที่ใช้งานบ่อย ๆ
extends Node

# สมการคำนวณความเร็วสำหรับ CharactorBody2D
func get_character_speed(_base_speed: int, _scale:Vector2 ) -> float:
	return (_base_speed * _scale.x) * (Global.tempo / 160) * (Global.TILE_SIZE  * Global.SCALE)
	

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


func process_bars(_bar: Array) -> Array:
	var first = _bar[0]
	var second = _bar[1]
	var third = _bar[2]
	if _bar[2] > 4:
		third = 1
		second += 1
	if second > 4:
		second = 1
		first += 1
	return [first, second, third, 0.0]	


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
