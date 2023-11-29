## กระสุนหรือพลังที่เกิดจากสกิล
extends Area2D
class_name Projectile


### Stats
## ระยะทางที่จะพุ่งไป (สามารถกำหนดได้ใน Skill Pattern)
var base_speed: int = 1
var direction: Vector2
var target
## ล็อคเป้าหมายหรือไม่
var is_target_lock: bool = false 
## ขนาดที่จะคูณ
var scale_multiplier: float = 1.0
var knockback_power: float = 1.0
var acceleration_rate: float = 1
## ความเสียหาย
var damage:int = 10


var timer: float
var delta: float
## ตัวละครที่ใช้สกิล
var caster: Node
var velocity: Vector2


var stats: Dictionary

func _ready() -> void:
	if caster:
		scale = caster.scale
	scale *= scale_multiplier
	knockback_power *= 10
	

func _physics_process(_delta) -> void:
	delta = _delta
	if is_target_lock: # ล็อคเป้าอ๊ะเปล่า
		direction = (target.global_position - global_position).normalized()
	var speed = Lib.get_character_speed(base_speed, scale) \
		* Global.seconds_per_bar * 0.25
	speed -= (acceleration_rate * 1000) * _delta
	#scale -= scale * ( 60 / Global.tempo ) * 0.1
	# if target:
		# velocity = target * speed
	velocity = (direction) * (speed)
	translate(velocity)
	process_duration() 
	# process_visual()
	
	
func process_duration() -> void:
	timer += delta
	if timer >= Global.seconds_per_bar:
		queue_free()
	
func process_visual() -> void:
	if Global.is_alpha_mode:
		modulate.a = 0.75
