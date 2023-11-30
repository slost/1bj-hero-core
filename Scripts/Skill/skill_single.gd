@icon("res://Assets/Icons/icon_skill.png")
extends Skill
class_name SkillSingle

## ข้อมูลสกิลจะเก็บไว้ในตัวแปรนี้
@export var data: SkillDB

## ค่าสถานะของกระสุนจะเก็บไว้ในตัวแปรนี้
@export var projectile_stats: ProjectileStats

@export var test: ProjectileSprite



func process_skill():
	process_beat(data)

# ประมวลผลการสปอนจากบีท
func process_beat(_data: SkillDB) -> void:
	if Global.bars[1] != bars[1]:
		bars[1] = Global.bars[1]
		data.can_spawn = true
	if match_beat(data.beat_test):
		if data.can_spawn:
			spawn_skill(data, projectile_stats)
			spawn_sound(data.sound_when_spawn, 10)
			data.can_spawn = false
