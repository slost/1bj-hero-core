extends TileMap
class_name SkillPattern

var layer: int = 0
var type = "type"


func _init():
	visible = false
	get_pattern_tiles()


func get_pattern_tiles() -> Array:
	var tile_map: Array = []
	for i in get_used_cells(layer):
		var tile: Array = []
		tile.append(Vector2(i.x, i.y))
		var tile_data = get_cell_tile_data(0, i)
		var _type = tile_data.get_custom_data(type)
		if _type == "se":
			print("go se")
			tile.append(_type)
		tile_map.append(tile)
	return tile_map
