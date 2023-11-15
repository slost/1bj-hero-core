extends Node


var character: Node # เทิร์นปัจจุบัน
var player: Node

var timer: float
var turn_number: int = 0

# ใช้เก็บข้อมูลในเทิร์นนั้น ๆ
var turn_data: Dictionary = {
	character = player,
	time = 6,
}

func _ready():
	set_turn_data(1)
	create_turn_queue()
	debug()
	
# ประมวลผลลำดับเทิร์น
func create_turn_queue():
	add_turn(Global.player)

# เพิ่มเทิร์นเข้า Global.turn_queue
func add_turn(_character: Node):
	var turn = Turn.new()
	turn.data = turn_data
	turn.data.number = turn_number
	turn_number += 1
	turn.data.character = _character
	print(turn.data)
	Global.turn_queue.append(turn)
	
	
func set_turn_data(_turn: int) -> void:
	turn_data.character = player
	

# สำหรับใช้ debug
func debug():
	print("END TURN")
	print("TURN QUEUE")
	print(Global.turn_queue)
	for i in Global.turn_queue:
		print_debug(i.data)


var turn_timer:float = 0

func on_end_turn():
	turn_timer = Global.turn_queue[0].data.time
	Global.turn_queue.erase(0)
	add_turn(Global.player)
	print(Global.turn_queue[0].data.character)


func _process(_delta):
	if Global.player:
		turn_timer -= _delta

		if turn_timer <= 0:
			on_end_turn()
