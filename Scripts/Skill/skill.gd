extends Resource
class_name Skill

## สไปรต์กระสุน
@export var sprite: PackedScene
## รูปแบบของกลุ่มกระสุน เช่น ไปซ้าย อยู่เฉย ๆ และตำแหน่งของกระสุนทั้งหมด
@export var pattern: PackedScene
## จังหวะเพลงที่จะสปอนแพทเทิร์นกระสุน
@export var beat: PackedScene
@export var beat_test: String = "1"
## เสียงที่จะปล่อยตอนปล่อยกระสุน
@export_file() var sound_when_spawn: String

@export_category("ค่ากระสุน")
## ความเสียหายฐาน
@export var base_damage: int
## ค่าที่จะนำไปคูณกับขนาด
@export var scale_multiplier: int = 1
@export var knockback_power: float = 1
## ความเร็ว
@export var base_speed: int = 1
## ระยะเวลา (หน่วยเป็นบาร์ตามจังหวะเพลง)
@export var duration: Array = [1, 0, 0]
## อัตราเร่ง
@export var acceleration_rate: float
@export var is_target_lock: bool
@export var is_rotation_to_direction: bool

