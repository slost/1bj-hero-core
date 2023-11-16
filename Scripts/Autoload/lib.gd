## Library สำหรับเก็บฟังชันก์ที่ใช้งานบ่อย ๆ
extends Node

# สมการคำนวณความเร็วสำหรับ CharactorBody2D
func get_character_speed(_base_speed: int, _scale:Vector2 ) -> float:
	return (_base_speed * _scale.x) * (Global.tempo / 160) * (Global.TILE_SIZE  * Global.SCALE)
	

func get_seconds_per_bar(_tempo: float) -> float:
	return 60.0 / _tempo

func process_bars(_bar: Array) -> Array:
	var first = _bar[0]
	var second = _bar[1]
	var third = _bar[2]
	if _bar[2] > 4:
		third = 1
		second += 1
	if second > 4:
		second = 1
		first += 1
	return [first, second, third, 0.0]	
