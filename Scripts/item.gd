## คลาสไอเทมผู้เล่น
@icon("res://Assets/Icons/icon_item.png")
extends Node
class_name Item

@export_category("Infomation")
## ชื่อ
@export var NAME: = "Item"
## คำอธิบาย
@export_multiline var description = ""
## ประเภทของไอเทม (Command ยังไม่ทำ)
@export_flags("Passive", "Auto Attack", "Auto Defendse", "Command") var type = 0

## ทำงานอยู่หรือไม่
@export var is_active: bool = true
