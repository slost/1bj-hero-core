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
		Global.base_tempo += 2
	if Input.is_action_pressed("debug_tempo_decrease"):
		Global.base_tempo -= 2
	if Input.is_action_pressed("debug_toggle_filter"):
		for i in filter.get_children():
			if Global.options["crt"] == false:
				Global.options["crt"] = true
				i.visible = true
			else:
				Global.options["crt"] = false	
				i.visible = false
	if Input.is_action_just_pressed("debug_lose_all_items"):
		Global.player.lose_all_items()
	if Input.is_action_just_pressed("debug_lose_a_items"):
		Global.player.lose_random_item()
		
func _process(_delta):
	if Global.is_debugging:
		debugger.text = ""
		add_text("HEROCORE v.1bj.0.666.1")
		add_text("*DEBUGGER*")
		add_text("Shortkey")
		add_text("F1: RESTART")
		add_text("F2: Toggle Filter")
		add_text("F3: Lose ALL ITEMS")
		add_text("F4: Lose a random ITEM")
		add_text("NUMPAD +/-: change tempo")
		
		
		add_text("\nITEMS: %s" % Global.player.get_item_amount())
		
		add_text("\nGAME") 
		
		if Global.turn_queue:
			var turn = Global.turn_queue[0]
			
			add_text("Turn: %s" % turn.data.number)
			if turn.data.character.name:
				add_text("# %s" % turn.data.character.name)
			var turn_time = "%.2f" % turn.data.time
			add_text("Time left %ss" % turn_time)
		
		add_text("\nMUSIC")
		add_text("Bars: %s" % get_bars_string())
		# add_text("musicH.bars %s" % str(musicH.bars))
		# add_text("player.bars: %s" % str(Global.player.bars))
		# add_text("player.bar_counter: %s" % str(Global.player.bar_counter))
		add_text("Bar Timer: %s" % str(musicH.timer))
		
		
		debugger.text +=  "Base Tempo: %s bpm" % Global.base_tempo
		
func add_text(_text: String) -> void:
	debugger.text += _text
	debugger.text += "\n"


func get_bars_string():
	return str(Global.bars[0]) + ":" + str(Global.bars[1]) + ":" + str(Global.bars[2]) + ":" + str(Global.bars[3]) 
