## ค่าสถานะกระสุน
extends Resource
class_name ProjectileStats

## ความเสียหายฐาน
@export var base_damage: int = 10
## ความเร็ว
@export var base_speed: int = 1
## อัตราเร่ง
@export var acceleration_rate: float
## ระยะเวลา (หน่วยเป็นบาร์ตามจังหวะเพลง)
@export var duration: Array = [1, 0, 0]

## ล็อคเป้าหมายหรือไม่
@export var is_target_lock: bool
## หมุนตามทิศทางทีจะไปหรือไม่
@export var is_rotation_to_direction: bool

## ค่าที่จะนำไปคูณกับขนาด
@export var scale_multiplier: int = 1

func get_stats():
    return {
        "base_damage": base_damage,
        "base_speed": base_speed,
        "acceleration_rate": acceleration_rate,
        "duration": duration,
        "is_target_lock": is_target_lock,
        "is_rotation_to_direction": is_rotation_to_direction,
        "scale_multiplier": scale_multiplier,
    }