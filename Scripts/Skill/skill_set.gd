## ควบคุมการปล่อยสกิล
extends Node
class_name SkillSet

## สกิลที่จะมีในสกิลเซ็ตนี้
@export var skills: Array[Skill] = []
"""
Skill: resource = {
	projectile = กระสุนที่จะสปอน
	pattern = รูปแบบของกลุ่มกระสุน เช่น ไปซ้าย อยู่เฉย ๆ และตำแหน่งของกระสุนทั้งหมด
	beat = จังหวะเพลงที่จะสปอนแพทเทิร์นกระสุน
	sound = เสียงที่จะปล่อยตอนปล่อยกระสุน
	}
"""

@onready var player: Node = $"../.."
@onready var caster: Node = $"../.."


var bars: int = 1
var hostile: Node
var patterns: Array = []
var current_turn: Turn

func set_hostile() -> void:
	if not caster == Global.player:
		hostile = Global.player
	else:
		hostile = Global.player # เดี๋ยวจะเปลี่ยนเป็น enemy

func _ready():
	caster = $"../.."
	set_hostile()


func _process(_delta) -> void:
	if Global.turn_queue.size() > 0:
		current_turn = Global.turn_queue[0]
	if current_turn.data.character == caster:
		if Global.bars >= bars:
			
			if Global.bars % 2 == 0:	
				spawn_skill(0)
			bars += 1
	else:
		bars = Global.bars
		
		
# สปอนแพทเทิร์นกระสุนจาก id ของอาร์เรย์ใน skills
func spawn_skill(_id: int) -> void:
	var skill = skills[_id]
	print(skill)
	var proj = skill.projectile
	var pattern = skill.pattern.instantiate()
	var pattern_tiles = pattern.get_pattern_tiles()
	print(pattern_tiles)
	print(skill.pattern)
	print(pattern.name)
	print_debug(pattern_tiles)
	for tile in pattern_tiles:
		print(tile)
		spawn_projectile(proj, tile[0])
	

# สปอนกระสุนจากซีนกระสุน
func spawn_projectile(_projectile: PackedScene,_tile: Vector2) -> void:
	var proj = _projectile.instantiate()
	proj.global_position = caster.global_position + \
		(caster.scale * _tile * Global.TILE_RES)
	proj.caster = caster
	$"..".add_child(proj)
	print(caster.global_position)
	print_debug("spawnned "  + str(proj.name) + str(proj.global_position))
	

# ใช้สปอนสกิล arg0 = id skill, arg1 = paremeters (จะใส่ไม่ใส่ก็ได้)
"""
func spawn_projectile(_projectile: String, _params = null) -> void:
	var spawn_loc = _params.get("spawn_loc", Vector2(0, 0)) # ตำแหน่งสปอน
	var spawn_dist = _params.get("spawn_dist", 0) # ระยะห่างจากตำแหน่งสปอน
	var proj_scale = _params.get("proj_scale", 1) # ขนาด projectile
	var proj_dir = _params.get("proj_dir", Vector2(0, 0)) 
	var spawn_position = caster.global_position \
	+ ( (spawn_loc * Global.TILE_SIZE  * caster.scale) ) * (spawn_dist + 1)
	proj.scale = proj_scale * Global.SCALE_VEC
	proj.global_position = spawn_position
	proj.target = (proj_dir - proj.global_position).normalized()
	$"..".add_child(proj)
"""
	
"""
func spawn_projectile_pattern(_skill: String, _pattern: String, _params = null) -> void:
	var spawn_dist = _params.get("spawn_dist", 0)
	# var pattern_tiles = pattern.get_pattern_tiles()
	# print_debug(pattern_tiles)
	
"""
		
