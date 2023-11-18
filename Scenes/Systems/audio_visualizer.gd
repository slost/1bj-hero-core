extends Node2D

@export var bus: String = "Master"

const VU_COUNT = 16

const FREQ_MAX = 11050.0

const WIDTH = 400
const HEIGHT = 100

const MIN_DB = 60

var spectrum


func _ready():
	var bus_id: int
	match bus:
		"Master":
			bus_id = 0
		"Player":
			bus_id = 1
		"Monster":
			bus_id = 2
	spectrum = AudioServer.get_bus_effect_instance( bus_id,0)


func _process(_delta):
	queue_redraw()


func _draw():
	#warning-ignore:integer_division
	var w = WIDTH / VU_COUNT
	var prev_hz = 0
	for i in range(1, VU_COUNT+1):
		var hz = i * FREQ_MAX / VU_COUNT;
		var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		var energy = clamp((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1)
		var height = energy * HEIGHT
		draw_rect(Rect2(w * i, HEIGHT - height, w, height), Color.WHITE)
		prev_hz = hz
