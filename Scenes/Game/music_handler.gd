extends Node

@export var tempo: float = 300
@export var listener: Node
@export var is_metronome_enabled: bool

var time: float = 0.0
var current_bar: int = 1
var sub_bar: int = 1
var bar_timer: float = 0.0

var verse: int = 0
var timer: float = 0.0

var is_played = false

var bars: Array = Global.bars

func _init():
	bars[0] = 1
	bars[1] = 1
	
	
func _process(_delta) -> void:
	
	Global.musicH = self
	
	var is_music_on = true
	if is_music_on:
		listener.global_position = Global.player.global_position
		listener.scale = Global.player.scale

	Global.tempo = tempo
	Global.bars = bars
	
	var sec_per_bar = Global.seconds_per_bar
	
	
	var i = sec_per_bar * 0.1
	
	time += _delta
	timer += _delta
	
	
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
		
	if is_metronome_enabled:
		play_metronome()
	
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
