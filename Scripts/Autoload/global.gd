## สคริปต์สำหรับรวบรวม Global variables
extends Node

# ถาดสี
var palette: Array = [Color.html("#000000"), Color(128.0, 0.0, 128.0, 1.0)]
var palettes: Array = [palette] # อาเรย์ถาดสี (เผื่อทำระบบเปลี่ยนถาดสี)

# Gamemode
var is_alpha_mode: bool = true # โหมดแสดงผลความโปร่งใส
var is_debugging: bool = true

# Resolution
const TILE_SIZE = 16 # ขนาดไทล์
const TILE_RES = Vector2(TILE_SIZE, TILE_SIZE)
const SCALE = 4
const SCALE_VEC = Vector2(4, 4)

# เพลง
var tempo: float
var bars: int = 1
var seconds_per_bar: float

# Node
var map: Node
var player: Node
var musicH: Node

# Game States
var turn_queue: Array = [] # ใช้เก็บคิวเทิร์น
var turn: int

func restart_game():
	turn_queue = []
	bars = 1
	print_debug("Restarted")


func _process(_delta):
	seconds_per_bar = Lib.get_seconds_per_bar(tempo)
