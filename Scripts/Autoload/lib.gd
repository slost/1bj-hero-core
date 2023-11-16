## Library สำหรับเก็บฟังชันก์ที่ใช้งานบ่อย ๆ
extends Node

# สมการคำนวณความเร็วสำหรับ CharactorBody2D
func get_character_speed(_base_speed: int, _scale:Vector2 ) -> float:
	return (_base_speed * _scale.x ) * (Global.tempo / 160) * (Global.TILE_SIZE  * Global.SCALE)
	

func get_seconds_per_bar(_tempo: float) -> float:
	return 60.0 / _tempo
