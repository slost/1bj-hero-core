extends Node
class_name Skill

# ผู้ใช้สกิล
@onready var caster: Node = $"../../.."
# ศัตรูที่ถูกโจมตี
var hostile: Node
# ซีนกระสุน
@onready var projectile_scene = load("res://Scenes/Skills/projectile.tscn")

# เทิร์นปัจจุบัน
var current_turn: Turn

var can_spawn = true


func _process(_delta) -> void:
	if Global.turn_queue.size() > 0:
		current_turn = Global.turn_queue[0]
		if current_turn.data.character == caster:
			process_skill()


func process_skill():
	pass


# ประมวลผลการสปอนจากบีท
func process_beat(_data: SkillDB) -> void:
	var skill = SkillDB
	if Global.bars[1] != skill.bars[1]:
		skill.bars[1] = Global.bars[1]
		skill.can_spawn = true
	if match_beat(skill.beat_test):
		if skill.can_spawn:
			spawn_skill(skill)
			spawn_sound(skill.sound_when_spawn, 10)
			skill.can_spawn = false


func spawn_skill(_data: SkillDB) -> void:
	var skill = _data
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


# สปอนซีนกระสุนจาก data ที่ได้จากแพทเทิร์น
func spawn_projectile(_data: Dictionary) -> void:
	var proj = projectile_scene.instantiate()
	proj.caster = caster
	proj.global_position = caster.global_position + \
		(caster.scale * _data.position * Global.TILE_RES)
	proj.direction = get_projectile_direction(_data.direction)
	# proj.scale_multiplier = _data.scale_multiplier
	$"..".add_child(proj)


# หาทิศทางที่กระสุนจะไป
func get_projectile_direction(_direction: String) -> Vector2:
	if Lib.get_direction(_direction) is Vector2:
		return Lib.get_direction(_direction)
	match _direction:
		"nearest_enemy":
			return (hostile.global_position - caster.global_position).normalized()
	return Vector2.ZERO

# สร้าง AudioStreamPlayer2D ในโหนด MusicHanlder
func spawn_sound(_sound_path: String, _db: float) -> void:
	var sound = Sound.new()
	if caster == Global.player:
		sound.bus = "Player"
	else:
		sound.bus = "Monster"
	sound.global_position = caster.global_position
	sound.volume_db += _db
	sound.stream = load(_sound_path) 
	Global.musicH.add_child(sound)


# ตรงกับจังหวะที่กำหนดหรือไม่
func match_beat(_beat_test: String) -> bool:	
	match _beat_test:
		"1": 
			return Global.bars[0] % 1 == 0
		"2":
			return Global.bars[0] % 2 == 0
		"3":
			return Global.bars[0] % 3 == 0
		"4":
			return Global.bars[0] % 3 == 0
		"1b":
			return Global.bars[0] % 8 == 1
		"8b":
			match Global.bars[0]:
				1:
					return true
		".1":
			return Global.bars[1] % 1 == 0
		".2":
			return Global.bars[1] % 2 == 0
	return false
