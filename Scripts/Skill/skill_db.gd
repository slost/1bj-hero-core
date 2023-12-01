## ข้อมูลสกิล
extends Resource
class_name SkillDB

## ตำแหน่งที่สกิลจะสปอน
@export_enum("Caster", "All Enemy", "Closest Enemy", "Furtest Enemy") var spawn_location: String = "Caster"
## สไปรต์กระสุน
@export var sprite: PackedScene
## รูปแบบของกลุ่มกระสุน เช่น ไปซ้าย อยู่เฉย ๆ และตำแหน่งของกระสุนทั้งหมด
@export var pattern: PackedScene
## จังหวะเพลงที่จะกำหนดเวลาสปอนแพทเทิร์นกระสุน
@export var beat: PackedScene
@export var beat_test: String = ".1"
## เสียงที่จะเล่นตอนปล่อยกระสุน
@export_file() var sound_when_spawn: String


var can_spawn: bool = true
var bars: Array = [1,1,1,0.0]


func _init():
	sound_when_spawn = "res://Assets/Audio/Gameplay/kick.wav"	
	pattern = load("res://Database/Patterns/พุ่งออกจากตัว.tscn")
	sprite = load("res://Database/ProjectileSprites/ProjectileSprite.tscn")
