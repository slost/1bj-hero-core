extends Node

@export var musicH: Node
@export var debugger: Node
@export var map: Node
@export var filter: Node


func _input(_event):
	if Input.is_action_pressed("debug_restart"):
		get_tree().reload_current_scene()
		Global.restart_game()
	if Input.is_action_pressed("debug_tempo_increase"):
		musicH.tempo += 2
	if Input.is_action_pressed("debug_tempo_decrease"):
		musicH.tempo -= 2
	if Input.is_action_pressed("debug_toggle_filter"):
		for i in filter.get_children():
			i.visible = false

func _process(_delta):
	if Global.is_debugging:
		debugger.text = ""
		add_text("*DEBUGGER*")
		add_text("Shortkey")
		add_text("F1: RESTART")
		add_text("F2: Toggle Filter")
		add_text("NUMPAD +/-: change tempo")
		
		
		add_text("\nGAME")
		
		if Global.turn_queue:
			var turn = Global.turn_queue[0]
			add_text("Turn: %s" % turn.data.number)
			add_text("# %s" % turn.data.character)
			add_text("Time left %ss" % round(turn.data.time))
		
		add_text("\nMUSIC")
		debugger.text +=  "Tempo: %s bpm\n" % musicH.tempo  + \
		"Time: " + str(round(musicH.time)) + "s" + "\nBeats: "+ str(musicH.beats) + "." + str(musicH.bars) 
		
		
func add_text(_text: String) -> void:
	debugger.text += _text
	debugger.text += "\n"
