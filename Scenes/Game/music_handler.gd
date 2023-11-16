extends Node

@export var tempo: float = 300
@export var listener: Node

var time: float = 0.0
var beats: int = 1
var bars: int = 1
var bar_timer: float = 0.0
var beats_timer: float = 0.0

var is_played = false


func _ready() -> void:
	Global.bars = 1


func _process(_delta) -> void:
	
	Global.musicH = self
	
	var is_music_on = true
	if is_music_on:
		listener.global_position = Global.player.global_position
		listener.scale = Global.player.scale

	Global.tempo = tempo
	
	var sec_per_bar = Global.seconds_per_bar

	time += _delta
	bar_timer += _delta
	
	if bar_timer >= sec_per_bar:
		Global.bars += 1
		is_played = false
		bars += 1
		bar_timer -= sec_per_bar
		
	if bars > 4:
		bars = 1
		beats += 1

	
func test_sound():	
	if !is_played:
		play_sound(1, $Kick)
		play_sound(2, $Snare)
		is_played = true

func play_sound(_bar, _sound) -> void:
	if bars == _bar:
		_sound.play()
