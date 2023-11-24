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

var is_played = false

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

	Global.tempo = (Global.player.get_item_amount() + 1) * Global.base_tempo / 3
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
	
	bars = Lib.process_bars(bars)
	
	
	if bar_timer >= sec_per_bar:
		Global.sub_bar += 1
		is_played = false
		sub_bar += 1
		bar_timer -= sec_per_bar
		
	if sub_bar > 4:
		sub_bar = 1
		current_bar += 1
		
	# if is_metronome_enabled:
	 # play_metronome()
	
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

	
func test_sound():	
	if !is_played:
		play_sound(1, $Kick)
		play_sound(2, $Snare)
		is_played = true

func play_sound(_bar, _sound) -> void:
	if sub_bar == _bar:
		_sound.play()
