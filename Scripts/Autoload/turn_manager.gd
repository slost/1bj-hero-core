extends Node


var character: Node # เทิร์นปัจจุบัน
var player: Node

var turn_number: int = 0


# สร้างลำดับเทิร์น
func create_turn_queue():
	for i in Global.map.get_children():
		if i is CharacterBody2D:
			add_turn(i)

	
# เพิ่มเทิร์นเข้า Global.turn_queue
func add_turn(_character: Node):
	var _turn = Turn.new()
	_turn.data = get_turn_data(_character)
	turn_number += 1
	_turn.data.time = ((600 / 100 ) / 4) + 1
	print(Global.seconds_per_bar)
	Global.turn_queue.append(_turn)
	debug()
	

# ใช้รีเทิร์นข้อมูลข้อมูลของเทิร์นนั้น ๆ
func get_turn_data(_character: Node) -> Dictionary:
	return {
	character = _character,
	number = turn_number,
	time = Global.seconds_per_bar
	}
	

# สำหรับใช้ debug
func debug():
	print("END TURN")
	print("TURN QUEUE")
	print(Global.turn_queue[0].data)


func on_end_turn():
	Global.turn_queue.pop_front()
	if Global.turn_queue.size() == 0:
		create_turn_queue()
		print_debug(Global.turn_queue[0].data)


func _process(_delta):
	
	var turn = Global.turn_queue[0]
	turn.data.time -= _delta
	if turn.data.time <= 0.0:
		on_end_turn()
	




			
