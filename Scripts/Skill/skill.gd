extends Resource
class_name Skill


@export var projectile: PackedScene
## รูปแบบของกลุ่มกระสุน เช่น ไปซ้าย อยู่เฉย ๆ และตำแหน่งของกระสุนทั้งหมด
@export var pattern: PackedScene
## จังหวะเพลงที่จะสปอนแพทเทิร์นกระสุน
@export var beat: PackedScene
@export_file() var sound: String

