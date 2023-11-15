extends Node

@export var tempo: float = 300

var time: float = 0.0
var beats: int = 1
var bars: int = 1
var bar_timer: float = 0.0
var beats_timer: float = 0.0

var is_played = false


func _ready() -> void:
	Global.bars = 1


func _process(_delta) -> void:

	Global.tempo = tempo
	
	var sec_per_bar = Global.seconds_per_bar

	time += _delta
	bar_timer += _delta
	print_debug(sec_per_bar)
	
	if bar_timer >= sec_per_bar:
		Global.bars += 1
		is_played = false
		bars += 1
		bar_timer -= sec_per_bar
		
	if bars > 4:
		bars = 1
		beats += 1

		
	if !is_played:
		play_sound(1, $Kick)
		play_sound(2, $Kick)
		play_sound(4, $Kick)
		play_sound(3, $Kick)
		
		play_sound(2, $Snare)
		play_sound(4, $Snare)
		is_played = true
	

func play_sound(_bar, _sound) -> void:
	if bars == _bar:
		_sound.play()
