extends Node

@onready var text_box_scene = preload("res://Scenes/Systems/text_box.tscn")

var dialog_lines: Array[String] = []
var current_line_index = 0

var text_box
var text_box_position: Vector2

var is_dialog_active = false
var can_advance_line = false

var is_fix_massagebox = false

#@onready var PositionTextBox = get_tree().root.get_node('/root/Game/PaletteShader/SubViewport/Map/DialogCanvasLayer/PositionTextBox')
#var fix_text_box_position = Vector2(384, 640)
var fix_box

func start_dialog(position: Vector2, lines: Array[String], fix_massagebox:bool = false):
	if is_dialog_active:
		return
	dialog_lines = lines
	if fix_massagebox:
		is_fix_massagebox = true
		var fix_box = Global.dialogCanvas.get_node("TextBox - DEBUG")#Global.map.get_node("DialogCanvasLayer/PositionTextBox")
		text_box_position = fix_box.position
	else:
		text_box_position = position
	_show_text_box()
	is_dialog_active = true

func _show_text_box():
	text_box = text_box_scene.instantiate()
	text_box.finsished_displaying.connect(_on_text_box_finished_displaying)
	#get_tree().root.get_node('/root/Game/SubViewportContainer/SubViewport').add_child(text_box)
	#get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	if is_fix_massagebox:
		text_box.set_fix_massagebox()
		#Global.map.get_node('DialogCanvasLayer').add_child(text_box)
		Global.dialogCanvas.add_child(text_box)
		#text_box.set_anchors_preset(Control.PRESET_CENTER, true)
		
		var fix_box = Global.dialogCanvas.get_node("PositionTextBox")#Global.map.get_node("DialogCanvasLayer/PositionTextBox")
		text_box_position = fix_box.position
		
		print_debug(Global.dialogCanvas.get_node("PositionTextBox").position)
		print_debug(Global.dialogCanvas.get_node("TextBox - DEBUG").position)
		
		#text_box.set_position(text_box_position)
		#text_box.set_anchors_preset(Control.PRESET_CENTER)
		#text_box.position.x = text_box_position.x + text_box_position.x / 2
		#text_box.position.y = text_box_position.y + text_box_position.y / 2
		text_box.pivot_offset.x = text_box.size.x / 2
		text_box.pivot_offset.y = text_box.size.y / 2
		#text_box.set_anchors_preset(Control.PRESET_CENTER, true)
		
	else:
		get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	
	text_box.display_text(dialog_lines[current_line_index])
	can_advance_line = false

func _on_text_box_finished_displaying():
	can_advance_line = true
	text_box.show_cursor_dialog()

func _unhandled_input(event):
	if (
		event.is_action_pressed("advance_dialog") &&
		is_dialog_active &&
		can_advance_line
	):
		text_box.queue_free()
		current_line_index += 1
		if current_line_index >= dialog_lines.size():
			is_dialog_active = false
			current_line_index = 0
			return
		_show_text_box()
