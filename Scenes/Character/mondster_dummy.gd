extends CharacterBody2D
class_name MonsterDummy

@onready var player = $"..".get_node("Player")

enum MONSTER_STATE {
	IDLE,
	CHASE,
	ATTACK
}

enum MOVE_TYPE {
	NONE,
	DIRECT,
	ROUNDED, # เดินแบบวงกลมล้อมผู้เล่น
	ROUNDED_TO_PLYER, # เดินแบบวงกลมล้อมผู้เล่นก่อน จากนั้น จะค่อย ๆ ขยับเข้าไปใกล้ ๆ ผู้เล่นแบบวงกลม
	ROUNDED_CLOSE_PLYER  # ค่อย ๆ ขยับเข้าไปใกล้ ๆ ผู้เล่นแบบวงกลม
}

@export var move_behavior:MOVE_TYPE = MOVE_TYPE.NONE

@export var speed = 200

@export var radius = 200

var _angle = 0
var _radius = 0
var current_state

# ใช้จับเวลา ว่า กำลังวิ่งอยู่ในระยะวงกลมเป็นเวลา 5 วิหรือไม่
var round_move_timer_init = 5
var round_move_timer = 0
# ค่าความคลาดเคลื่อนที่ยอมรับได้ (สำหรับการเช็คว่าวิ่งอยู่ในระยะวงกลม)
var error_distance = 5
# อัตราการเดินเข้าใกล้ผู้เล่น (สำหรับการเช็คเดินเข้าใกล้แบบวงกลม)
var rate_close_player = 10

func _ready():
	current_state = MONSTER_STATE.IDLE
	_radius = radius
	round_move_timer = round_move_timer_init

func _process(_delta) -> void:
	match current_state:
		MONSTER_STATE.IDLE:
			match move_behavior:
				MOVE_TYPE.DIRECT:
					var direction = (player.global_position - global_position).normalized()
					velocity = direction * speed
				MOVE_TYPE.ROUNDED, MOVE_TYPE.ROUNDED_TO_PLYER, MOVE_TYPE.ROUNDED_CLOSE_PLYER:
					# ทำให้เดินเข้าไปใกล้ ๆ ผู้เล่น สำหรับ ROUNDED_CLOSE_PLYER
					if move_behavior == MOVE_TYPE.ROUNDED_CLOSE_PLYER:
						if _radius > 0:
							_radius = max(_radius - _delta * rate_close_player, 0)
					else:
						_radius = radius
					
					_angle += _delta
					#var offset = player.global_position - Vector2(sin(_angle), cos(_angle)) * _radius
					# With the following lines
					var offset_x = cos(_angle) * _radius
					var offset_y = sin(_angle) * _radius
					var offset = player.global_position - Vector2(offset_x, offset_y)

					var direction = (offset - global_position).normalized()
					var distance_offset = global_position.distance_to(offset)
					print_debug("distance_offset ", distance_offset)
					#velocity = direction * speed
					velocity = direction * speed
					
					# เช็คว่าเดินเป็นวงกลมแล้วยัง แล้วจะอัเดตสถานะการเดินเป็นเดินเข้าใกล้
					if move_behavior == MOVE_TYPE.ROUNDED_TO_PLYER:
						if round_move_timer > 0:
							var distance = global_position.distance_to(player.global_position)
							if distance >= ( radius - error_distance ) && distance <= ( radius + error_distance ):
								round_move_timer -= _delta
							else:
								round_move_timer = round_move_timer_init
							print_debug(distance)
						else:
							move_behavior = MOVE_TYPE.ROUNDED_CLOSE_PLYER
						
						print_debug(round_move_timer)
					# เช็คว่าผู้เล่นเดินหนีออกจากระยะ ให้กลับไปสถานะเดินวงกลมล้อมใหม่
					if move_behavior == MOVE_TYPE.ROUNDED_CLOSE_PLYER:
						var distance = global_position.distance_to(player.global_position)
						if distance >= ( radius + error_distance ):
							# ผู้เล่นวิ่งหนีไปไกลแล้ว รีเซ็ตสถานะ + ตัวแปร
							move_behavior = MOVE_TYPE.ROUNDED_TO_PLYER
							round_move_timer = round_move_timer_init
			
			move_and_slide()
