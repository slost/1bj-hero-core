extends Node
class_name Music

@onready var tempo = Global.base_tempo
@onready var bars: Array = [1, 1, 1]
@onready var seconds_per_bar: float = Lib.get_seconds_per_bar(tempo)

var time: float = 0.0
var timer: float = 0.0
var beat_timer: float = 0.0
var play: bool = false


func _process(_delta):
    if DialogManger.is_dialog_active:
        return
    if play:
        beat_timer = Lib.bars_to_seconds(bars, tempo)
        seconds_per_bar = Lib.get_seconds_per_bar(tempo)
        var i = seconds_per_bar * 0.5

        time += _delta
        timer += _delta

        if timer >= seconds_per_bar:
            bars[2] += 1
            timer -= seconds_per_bar * i
            
        if bars[2] > 4:
            bars[2] = 1
            bars[1] += 1
        if bars[1] > 4:
            bars[1] = 1
            bars[0] += 1
