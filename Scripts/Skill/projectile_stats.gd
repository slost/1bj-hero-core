## ค่าสถานะกระสุน
extends Resource
class_name ProjectileStats

## ความเสียหายฐาน
@export var base_damage: int = 10
## ระยะทางที่กระสุนนี้จะไป ความเร็วจะขึ้นอยู่กับระยะทางและระยะเวลา
@export var distance: int = 1
## อัตราเร่ง
@export var acceleration_rate: float
## ระยะเวลา (หน่วยเป็นบาร์ตามจังหวะเพลง)
@export var duration: Array = [1, 0, 0]


@export var knockback_power: int = 0

## ล็อคเป้าหมายหรือไม่
@export var is_target_lock: bool
## หมุนตามทิศทางทีจะไปหรือไม่
@export var is_rotation_to_direction: bool

## ค่าที่จะนำไปคูณกับขนาด
@export var scale_multiplier: float = 1.0

## จำนวนครั้งที่กระสุนจะเจาะ
@export var penetrate: int = 1

func get_stats():
    return {
        "distance": distance,
        "knockback_power": knockback_power,
        "base_damage": base_damage,
        "acceleration_rate": acceleration_rate,
        "duration": duration,
        "is_target_lock": is_target_lock,
        "is_rotation_to_direction": is_rotation_to_direction,
        "scale_multiplier": scale_multiplier,
    }