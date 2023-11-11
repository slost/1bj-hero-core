## สคริปต์สำหรับรวบรวม Global variables
extends Node

# ถาดสีหลัก
var main_pallet: Array = [Color.html("#000000"), Color.html("#800080")]

# อาเรย์ถาดสี (เผื่อทำระบบเปลี่ยนถาดสี)
var pallets: Array = [main_pallet]

var is_alpha_mode: bool = false # โหมดแสดงผลความโปร่งใส
var is_debugging: bool = true

var tile_size = 16 # ขนาดไทล์

var tempo: float
