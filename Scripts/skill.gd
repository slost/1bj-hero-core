extends Node

var proj_path = "res://Scenes/Skills/projectile.tscn"
var bars: int = 1

@onready var player: Node = $"../.."

var pattern

func _ready():
	pattern = $Around
	pattern.visible = false


func _process(_delta) -> void:
	if Global.bars >= bars:
		spawn_projectile("kick", {spawn_loc = Dir.MID, proj_scale = 8})
		if Global.bars % 2 == 0:
			spawn_projectile_pattern("kick", "around caster", {spawn_dist = 0})
		bars += 1
	

# ใช้สปอนสกิล arg0 = id skill, arg1 = paremeters (จะใส่ไม่ใส่ก็ได้)
func spawn_projectile(_skill: String, _params = null) -> void:
	var skill = load(proj_path).instantiate()
	# if _params != null:
	var spawn_loc = _params.get("spawn_loc", Vector2(0, 0)) # ตำแหน่งสปอน
	var spawn_dist = _params.get("spawn_dist", 0) # ระยะห่างจากตำแหน่งสปอน
	var proj_scale = _params.get("proj_scale", 1) # ขนาด projectile
	var skill_dir
	var spawn_position = player.global_position \
	+ ( (spawn_loc * Global.tile_size * player.scale) ) * (spawn_dist + 1)
	skill.scale = proj_scale * Global.scale
	skill.global_position = spawn_position
	$"..".add_child(skill)
	

func spawn_projectile_pattern(_skill: String, _pattern: String, _params = null) -> void:
	var spawn_dist = _params.get("spawn_dist", 0)
	var pattern_tiles = pattern.get_pattern_tiles()
	print(pattern_tiles)
	for tile in pattern_tiles:
		spawn_projectile("kick", {spawn_loc = tile[0], spawn_dist = spawn_dist})
		
