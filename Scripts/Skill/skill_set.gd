## ควบคุมการปล่อยสกิล
extends Node
class_name SkillSet

## สกิลที่จะมีในสกิลเซ็ตนี้
@export var skills: Array[Skill] = []

@onready var caster: Node = $"../../.."
@onready var projectile_scene = load("res://Scenes/Skills/projectile.tscn")
@onready var can_spawn = true

var bar_counter: int = 1
var hostile: Node
var patterns: Array = []
var current_turn: Turn


func _ready():
	# caster = $".."
	set_hostile()

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


# ประมวลผลการสปอนจากบีท
func process_beat():
	for skill in skills:
		if Global.bars[1] != skill.bars[1]:
			skill.bars[1] = Global.bars[1]
			skill.can_spawn = true
		if skill.match_beat():
			if skill.can_spawn:
				print(self.name + " Spawned: " + str(skill.bars[1]))
				spawn_skill_from_id(0)
				skill.can_spawn = false


		
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
