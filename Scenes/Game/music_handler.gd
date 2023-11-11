extends Node

@export var tempo: float = 140.0

var time: float = 0.0
var beats: int = 1
var bars: int = 1
var bar_timer = 0
var beats_timer = 0
var is_played = false

func _process(_delta) -> void:
	Global.tempo = tempo

	time += 1
	bar_timer += 1
	beats_timer += 1

	if beats_timer == tempo:
		beats += 1
		beats_timer = 0
		
	if bar_timer == tempo / 4:
		bars += 1
		bar_timer = 0
		
	if bars > 4:
		bars = 1	
	
	if Global.is_debugging:
		$Debugger.text = "Time: " + str(time) + " (" + str( round(time / 60) ) \
		+ "s)"+ "\nBeats: "+ str(beats) + "." + str(bars) 
	
	if !is_played:
		play_sound(1, $Kick)
		is_played = true


func play_sound(_bar, _sound) -> void:
	if bars == _bar:
		_sound.play()
