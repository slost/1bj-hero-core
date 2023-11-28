## ข้อมูลสกิล
extends Resource
class_name SkillDB

## ชื่อสกิล
@export var name: String = "Skill Name"
## สไปรต์กระสุน
@export var sprite: PackedScene
## รูปแบบของกลุ่มกระสุน เช่น ไปซ้าย อยู่เฉย ๆ และตำแหน่งของกระสุนทั้งหมด
@export var pattern: PackedScene
## จังหวะเพลงที่จะกำหนดเวลาสปอนแพทเทิร์นกระสุน
@export var beat: PackedScene
@export var beat_test: String = "1"
## เสียงที่จะเล่นตอนปล่อยกระสุน
@export_file() var sound_when_spawn: String

@export_category("ค่าสถานะกระสุน")
## ความเสียหายฐาน
@export var base_damage: int = 10
## ค่าที่จะนำไปคูณกับขนาด
@export var scale_multiplier: int = 1
@export var knockback_power: float = 1
## ความเร็ว
@export var base_speed: int = 1
## ระยะเวลา (หน่วยเป็นบาร์ตามจังหวะเพลง)
@export var duration: Array = [1, 0, 0]
## อัตราเร่ง
@export var acceleration_rate: float
## ล็อคเป้าหมายหรือไม่
@export var is_target_lock: bool
## หมุนตามทิศทางหรือไม่
@export var is_rotation_to_direction: bool


var can_spawn: bool = true
var bars: Array = [1,1,1,0.0]


func _init():
	sound_when_spawn = "res://Assets/Audio/Gameplay/kick.wav"	
	pattern = load("res://Database/Patterns/พุ่งออกจากตัว.tscn")
	

func match_beat() -> bool:	
	match beat_test:
		"1" : 
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
