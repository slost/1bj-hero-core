## สคริปต์สำหรับรวบรวม Global variables
extends Node

# ถาดสีหลัก
var main_pallet: Array = [
	Color.html("#000000"),
	Color.html("#800080")
]

# อาเรย์ถาดสี (เผื่อทำระบบเปลี่ยนถาดสี)
var pallets: Array = [
	main_pallet
]

# โหมดแสดงผลความโปร่งใส
var is_alpha_mode: bool = false

# ขนาดไทล์
var tile_size = 16
