## ควบคุมการปล่อยสกิล
extends Node

var proj_path = "res://Scenes/Skills/projectile.tscn"
var bars: int = 1

@export var pattern: Node

@onready var player: Node = $"../.."
@onready var caster: Node = $"../.."


func _process(_delta) -> void:
	if Global.bars >= bars:
		spawn_projectile("kick", {spawn_loc = Dir.MID, proj_scale = 4})
		if Global.bars % 2 == 0:
			spawn_projectile_pattern("kick", "around caster", {spawn_dist = 0})
		bars += 1
	

# ใช้สปอนสกิล arg0 = id skill, arg1 = paremeters (จะใส่ไม่ใส่ก็ได้)
func spawn_projectile(_projectile: String, _params = null) -> void:
	var proj = load(proj_path).instantiate()
	# if _params != null:
	var spawn_loc = _params.get("spawn_loc", Vector2(0, 0)) # ตำแหน่งสปอน
	var spawn_dist = _params.get("spawn_dist", 0) # ระยะห่างจากตำแหน่งสปอน
	var proj_scale = _params.get("proj_scale", 1) # ขนาด projectile
	var skill_dir
	var spawn_position = caster.global_position \
	+ ( (spawn_loc * Global.tile_size * caster.scale) ) * (spawn_dist + 1)
	proj.scale = proj_scale * Global.scale
	proj.global_position = spawn_position
	proj.add_collision_exception_with(caster)
	$"..".add_child(proj)
	

func spawn_projectile_pattern(_skill: String, _pattern: String, _params = null) -> void:
	var spawn_dist = _params.get("spawn_dist", 0)
	var pattern_tiles = pattern.get_pattern_tiles()
	# print_debug(pattern_tiles)
	for tile in pattern_tiles:
		spawn_projectile("kick", {spawn_loc = tile[0], spawn_dist = spawn_dist})
		
