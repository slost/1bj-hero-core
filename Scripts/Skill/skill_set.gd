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

@onready var caster: Node = $"../.."
@onready var projectile_scene = load("res://Scenes/Skills/projectile.tscn")

var bar_counter: int = 1
var hostile: Node
var patterns: Array = []
var current_turn: Turn


var bar_to_spawn: int = 3

var beat: Array = ["1","1", "1", "2"]


func _ready():
	# caster = $".."
	set_hostile()

var is_spawned = false

@onready var bars = Global.bars_init

# กำหนดค่าศัตรูให้กระสุน
func set_hostile() -> void:
	if not caster == Global.player:
		hostile = Global.player
	else:
		hostile = Global.player # เดี๋ยวจะเปลี่ยนเป็น enemy


func _process(_delta) -> void:
	if Global.turn_queue.size() > 0:
		current_turn = Global.turn_queue[0]
	if current_turn.data.character == caster:
		process_beat()
	else:
		bars = Global.bars_init
	

# ประมวลผลการสปอนจากบีท
func process_beat():
	if bars[1] != Global.bars[1]:
		bars[1] = Global.bars[1]
		is_spawned = false
	if match_beat() == 0 and not is_spawned:
		spawn_skill_from_id(0)
		is_spawned = true


func match_beat() -> int:	
	for skill in skills:
		match skill.beat_test:
			"1" : 
				return Global.bars[0] % 1
			"2":
				return Global.bars[0] % 2
			"3":
				return Global.bars[0] % 3
			"4":
				return Global.bars[0] % 3
			"1b":
				return (Global.bars[0] - 1) % 8
			"8b":
				return (Global.bars[0] -1) % 16
			".1":
				return Global.bars[1] % 1
			".2":
				return Global.bars[1] % 2
	return 1
		
		
# สปอนแพทเทิร์นกระสุนจาก id ของอาร์เรย์ใน skills
func spawn_skill_from_id(_id: int) -> void:
	var skill = skills[_id]
	var pattern = skill.pattern.instantiate()
	var pattern_data = Lib.get_pattern_data(pattern)
	# print_debug(pattern_data)
	for tile in pattern_data["direction"]:
		if skill.sound_when_spawn:
			tile["sound"] = skill.sound_when_spawn
			tile["scale_multiplier"] = skill.scale_multiplier
		if pattern_data["direction"].size() == 1:
			tile["db"] = 10
		else:
			tile["db"] = 0
		spawn_projectile(tile)
		# print(tile)

# สปอนกระสุนจากซีนกระสุน
func spawn_projectile(_data: Dictionary) -> void:
	var proj = projectile_scene.instantiate()
	proj.caster = caster
	proj.global_position = caster.global_position + \
		(caster.scale * _data.position * Global.TILE_RES)
	proj.direction = get_projectile_direction(_data.direction)
	proj.sound_path = _data.sound
	if _data.db:
		proj.db = _data.db
	proj.scale_multiplier = _data.scale_multiplier
	$"..".add_child(proj)
	

# หาทิศทางที่กระสุนจะไป
func get_projectile_direction(_direction: String):
	if Lib.get_direction(_direction) is Vector2:
		return Lib.get_direction(_direction)
	match _direction:
		"nearest_enemy":
			return (hostile.global_position - caster.global_position).normalized()
	return Vector2.ZERO	
	
"""
func spawn_projectile(_projectile: String, _params = null) -> void:
	var spawn_dist = _params.get("spawn_dist", 0) # ระยะห่างจากตำแหน่งสปอน
"""
		
