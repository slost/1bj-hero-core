extends Node2D


func _draw():
	# draw_background(Global.palette[1])
	pass
	

func draw_background(color: Color) -> void:
	var viewport_size = $"../../..".get_viewport().get_visible_rect().size
	var width = viewport_size.x
	var hieght = viewport_size.y
	draw_rect(Rect2(-width, -hieght, width, hieght), color)

func _ready():
	Global.map = self


# จับเวลาเริ่มเกม
func _on_timer_timeout():
	Global.is_ready = true
	TurnManager.create_turn_queue(self)
	print_debug("Game Started!")
