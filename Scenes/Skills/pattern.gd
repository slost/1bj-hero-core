@tool
extends TileMap
class_name SkillPattern

func _ready():
	# get_pattern_tiles()
	set("tile_set", load("res://Scenes/Skills/pattern_tile.tres"))
	set("layer_0/name", "direction")
	add_child(load("res://Database/Patterns/dummy_caster.tscn").instantiate())


