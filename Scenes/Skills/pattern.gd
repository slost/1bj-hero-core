@tool
extends TileMap
class_name SkillPattern

func _init():
	# get_pattern_tiles()
	set("tile_set", load("res://Scenes/Skills/pattern_tile.tres"))
	add_child(load("res://Database/Patterns/dummy_caster.tscn").instantiate())


