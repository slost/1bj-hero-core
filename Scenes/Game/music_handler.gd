extends Node

@onready var tempo = Global.base_tempo
@export var listener: Node
@export var is_metronome_enabled: bool

var time: float = 0.0
var current_bar: int = 1
var sub_bar: int = 1
var bar_timer: float = 0.0

var verse: int = 0
var timer: float = 0.0

@onready var bars: Array = [1, 1, 1, 1.0]

	
	
var current_turn: Turn
	

func _process(_delta) -> void:
	if Global.is_ready:
		process_music(_delta)
	
	
func process_music(_delta) -> void:
	
	Global.musicH = self
	
	var is_music_on = true
	if is_music_on:
		listener.global_position = Global.player.global_position
		listener.scale = Global.player.scale

	Global.tempo = Global.base_tempo

	Global.bars = bars
	
	var sec_per_bar = Global.seconds_per_bar
	
	
	var i = sec_per_bar * 0.5
	


	time += _delta
	timer += _delta
	var percentage_difference: float = (1.0 - timer / sec_per_bar) * 100.0
	# Global.bars[3] = round(percentage_difference)
	
	
	if timer >= sec_per_bar * i:
		bars[2] += 1
		timer -= sec_per_bar * i
	
	bars = Lib.fix_bars(bars)
	
	
	if Global.turn_queue.size() > 0:
		current_turn = Global.turn_queue[0]
		if current_turn.data.character == Global.player:
			AudioServer.set_bus_mute(2, true)
			
			AudioServer.set_bus_mute(1, false)
		else:
			AudioServer.set_bus_mute(2, false)
			AudioServer.set_bus_mute(1, true)
	
func play_metronome():
	if bars[1] == 1:
		$Kick.play()

	
func play_sound(_bar, _sound) -> void:
	if sub_bar == _bar:
		_sound.play()
