extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer
@onready var cursor_dialog = $NinePatchRect/ColorRect
@onready var audio_player = $AudioStreamPlayer

const MAX_WIDTH = 256*2.5

var text = ""
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

var fix_massagebox = false
var fix_size

signal finsished_displaying()

func set_fix_massagebox():
	fix_massagebox = true

func display_text(text_to_display: String):
	text = text_to_display
	if fix_massagebox:
		fix_size = Global.dialogCanvas.get_node("PositionTextBox").size
		custom_minimum_size = fix_size
		pivot_offset.x = fix_size.x / 2
		pivot_offset.x = fix_size.y / 2
		
		#set_size(fix_size)
		#reset_size()
		scale = Vector2()
		var tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(1,1), 0.5).set_trans(Tween.TRANS_BOUNCE)
		
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	else:
		label.text = text_to_display
		await resized
		custom_minimum_size.x = min(size.x, MAX_WIDTH)
		if size.x > MAX_WIDTH:
			label.autowrap_mode = TextServer.AUTOWRAP_WORD
			await resized
			await resized
			custom_minimum_size.y = size.y
		global_position.x -= size.x / 2
		global_position.y -= size.y + 24
	
	label.text = ""
	_display_letter()

func _display_letter():
	label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finsished_displaying.emit()
		return
	
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)
			
			var new_audio_player = audio_player.duplicate()
			new_audio_player.pitch_scale += randf_range(-0.1, 0.1)
			if text[letter_index] in ["a", "e", "i", "o", "u"]:
				new_audio_player.pitch_scale += 0.2
			get_tree().root.add_child(new_audio_player)
			new_audio_player.play()
			await new_audio_player.finished
			new_audio_player.queue_free()


func _on_letter_display_timer_timeout():
	_display_letter()

func show_cursor_dialog():
	cursor_dialog.visible = true
