## กระสุนหรือพลังที่เกิดจากสกิล
extends Area2D
class_name Projectile


const BASE_SPEED: int = 1
## ระยะทางที่จะพุ่งไป (สามารถกำหนดได้ใน Skill Pattern)
@export var direction: Vector2
## เป้าหมายที่จะพุ่งไปหา
@export var target: Vector2 
## ล็อคเป้าหมายหรือไม่
@export var target_lock: bool = false 
## ขนาดที่จะคูณ
@export var scale_size: int = 1

var timer: float
var delta: float
var caster: Node


func _ready() -> void:
	scale = caster.scale


func _physics_process(_delta) -> void:
	delta = _delta
	if target_lock:
		direction = (target - global_position).normalized()
	var speed = Lib.get_character_speed(BASE_SPEED, scale)
	# scale -= scale * ( 60 / Global.tempo ) * 0.1
	# if target:
		# velocity = target * speed
	var velocity = direction * speed
	process_visual()
	translate(velocity)
	process_duration() 
	
func process_visual() -> void:
	if Global.is_alpha_mode:
		modulate.a = 0.75


func process_duration() -> void:
	timer += delta
	if timer >= Global.seconds_per_bar:
		queue_free()
