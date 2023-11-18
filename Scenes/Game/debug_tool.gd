extends Node

@export var musicH: Node
@export var debugger: Node
@export var map: Node
@export var filter: Node

func _init():
	Global.debugTool = self

func _input(_event):
	if Input.is_action_pressed("debug_restart"):
		Global.restart_game()
		get_tree().reload_current_scene()
	if Input.is_action_pressed("debug_tempo_increase"):
		musicH.tempo += 2
	if Input.is_action_pressed("debug_tempo_decrease"):
		musicH.tempo -= 2
	if Input.is_action_pressed("debug_toggle_filter"):
		for i in filter.get_children():
			if Global.options["crt"] == false:
				Global.options["crt"] = true
				i.visible = true
			else:
				Global.options["crt"] = false	
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
			add_text("# %s" % turn.data.character.name)
			add_text("Time left %ss" % (turn.data.time))
		
		add_text("\nMUSIC")
		add_text("Bars: %s" % str(Global.bars))
		add_text("musicH.bars %s" % str(musicH.bars))
		add_text("player.bars: %s" % str(Global.player.bars))
		add_text("player.bar_counter: %s" % str(Global.player.bar_counter))
		add_text("Bar Timer: %s" % str(musicH.timer))
		
		
		debugger.text +=  "Tempo: %s bpm\n" % musicH.tempo  + \
		"Time: " + str(round(musicH.time)) + "s" + "\ncurrent_bar: "+ str(musicH.current_bar) + "." + str(musicH.sub_bar) 
		
		
func add_text(_text: String) -> void:
	debugger.text += _text
	debugger.text += "\n"
