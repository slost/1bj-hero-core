extends TileMap

var layer: int = 0
var type = "type"
var max_range: int = 10


func get_pattern_tiles() -> Array:
	var tile_map: Array = []
	for x in range(-max_range, max_range):
		for y in range(-max_range, max_range):
			var tile: Array = []
			var tile_data = get_cell_tile_data(0, Vector2(x, y))
			if tile_data:
				tile.append(Vector2(x, y))
				var _type = tile_data.get_custom_data(type)
				if _type == "se":
					print("go se")
					tile.append(_type)
				tile_map.append(tile)
	return tile_map
