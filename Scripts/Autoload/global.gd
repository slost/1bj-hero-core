## สคริปต์สำหรับรวบรวม Global variables
extends Node

# ถาดสี
var palette: Array = [Color.html("#000000"), Color(128.0, 0.0, 128.0, 1.0)]
var palettes: Array = [palette] # อาเรย์ถาดสี (เผื่อทำระบบเปลี่ยนถาดสี)

# Gamemode
var options: Dictionary = {
	"crt" = false,
	"noise" = true
}

var is_alpha_mode: bool = true # โหมดแสดงผลความโปร่งใส
var is_debugging: bool = true

# Resolution
const TILE_SIZE = 16 # ขนาดไทล์
const TILE_RES = Vector2(TILE_SIZE, TILE_SIZE)
const SCALE = 4
const SCALE_VEC = Vector2(4, 4)

# เพลง
var tempo: float
var base_tempo = 100
const BARS_INIT: Array = [1, 1, 1, 0.0]
var bars: Array = BARS_INIT
var seconds_per_bar: float

# Node
var map: Node
var player: Node
var musicH: Node
var dialogCanvas: Node
var debugTool: Node

# Game States
var turn_queue: Array = [] # ใช้เก็บคิวเทิร์น
var turn: int
var is_ready: bool = false

enum GAME_SCREEN {
	TITLE,
	LOAD,
	GAME,
	DISCARD
}
var cureent_state = GAME_SCREEN.TITLE


func restart_game():
	turn_queue = []
	bars = BARS_INIT
	print_debug("Restarted")


func _process(_delta):
	if debugTool:
		if options["crt"] == true:
			debugTool.filter.visible = true
		else:
			debugTool.filter.visible = false
		seconds_per_bar = Lib.get_seconds_per_bar(tempo)
