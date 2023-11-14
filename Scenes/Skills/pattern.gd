extends TileMap

var layer: int = 0
var type = "type"


func _ready():
	var tile_data = get_cell_tile_data(0, Vector2(1,1))
	
	
	if tile_data:
		var _type = tile_data.get_custom_data(type)
		if _type == "se":
			print("go se")
