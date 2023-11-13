## สคริปต์สำหรับรวบรวม Global variables
extends Node

# ถาดสีหลัก
var palette: Array = [Color.html("#000000"), Color(128.0, 0.0, 128.0, 1.0)]

# อาเรย์ถาดสี (เผื่อทำระบบเปลี่ยนถาดสี)
var palettes: Array = [palette]

var is_alpha_mode: bool = true # โหมดแสดงผลความโปร่งใส
var is_debugging: bool = true

var tile_size = 16 # ขนาดไทล์
var scale = Vector2(4, 4)

var player: Node

# เพลง
var tempo: float
var bars: int = 1
