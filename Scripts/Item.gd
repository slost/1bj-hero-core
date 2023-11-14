extends Node

var skill_path = "res://Scenes/Skills/skill.tscn"
var bars: int = 1

@onready var player: Node = $"../.."


func _process(_delta) -> void:
	if Global.bars >= bars:
		spawn_skill("kick", {skill_scale = 4})
		if Global.bars % 2 == 0:
			spawn_skill_pattern("kick", "around caster", {spawn_dist = 1})
		bars += 1
	

# ใช้สปอนสกิล arg0 = id skill, arg1 = paremeters (จะใส่ไม่ใส่ก็ได้)
func spawn_skill(_skill: String, _params = null) -> void:
	var skill = load(skill_path).instantiate()
	# if _params != null:
	var spawn_loc = _params.get("spawn_loc", "mid")
	var spawn_dist = _params.get("spawn_dist", 0)
	var skill_scale = _params.get("skill_scale", 1)
	var skill_dir
	var spawn_position = player.global_position + \
		( get_spawn_location(spawn_loc)  * (spawn_dist + 1) )
	skill.scale = (skill_scale * Global.scale)
	skill.global_position = spawn_position
	$"..".add_child(skill)
	

func spawn_skill_pattern(_skill: String, _pattern: String, _params = null) -> void:
	var spawn_dist = _params.get("spawn_dist", 0)
	match _pattern:
		"around caster":
			spawn_skill(_skill, {spawn_loc = "n", spawn_dist = spawn_dist})
			spawn_skill(_skill, {spawn_loc = "nw"})
			spawn_skill(_skill, {spawn_loc = "e"})
			spawn_skill(_skill, {spawn_loc = "w"})
			spawn_skill(_skill, {spawn_loc = "s"})
			spawn_skill(_skill, {spawn_loc = "ne"})
			spawn_skill(_skill, {spawn_loc = "sw"})
			spawn_skill(_skill, {spawn_loc = "se"})


# รีเทิร์นตำแหน่ง arg0 = ตำแหน่ง, arg1 = ระยะห่างจากตำแหน่งนั้น
func get_spawn_location(_location: String) -> Vector2:
	var loc_vec: Vector2
	match _location:
		"nw":
			loc_vec = -Vector2.ONE 
		"n":
			loc_vec = Vector2.UP
		"ne":
			loc_vec = Vector2(1,-1)
		"w":
			loc_vec = Vector2.LEFT
		"mid":
			loc_vec = Vector2.ZERO
		"e":
			loc_vec = Vector2.RIGHT
		"sw":
			loc_vec = Vector2(-1,1)
		"s":
			loc_vec = Vector2.DOWN
		"se":
			loc_vec = Vector2.ONE 
	return loc_vec * Global.tile_size * player.scale
		

