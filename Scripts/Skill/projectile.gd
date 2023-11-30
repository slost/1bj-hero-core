## กระสุนหรือพลังที่เกิดจากสกิล
extends Area2D
class_name Projectile

@onready var bars = caster.bars

### Stats
## ระยะทางที่จะพุ่งไป (สามารถกำหนดได้ใน Skill Pattern)
var direction: Vector2
var base_speed: int = 1
var target
## ล็อคเป้าหมายหรือไม่
var is_target_lock: bool = false 
## ขนาดที่จะคูณ
var scale_multiplier: float = 1.0
var knockback_power: float = 1.0
var acceleration_rate: float = 1
## ความเสียหาย
var damage:int = 10


var timer = 0.0

var dur = [0, 2, 0]

var sprite = null
var delta: float
## ตัวละครที่ใช้สกิล
var caster: Node
var velocity: Vector2

var stats: Dictionary = {
	"damage": 10,
	"base_speed": 1,
	"scale_multiplier": 1.0,
	"knockback_power": 1.0,
	"acceleration_rate": 1.0,
	"duration": [1, 0, 0],
	"target": null,
	"is_target_lock": false,
}

var timeout_bars 

func _init():
	pass

func _ready() -> void:
	if caster:
		scale = caster.scale
	scale *= stats.scale_multiplier
	knockback_power *= 10
	create_sprite()
	get_timeout_bars(bars, dur)
	timeout_bars = get_timeout_bars(bars, stats.duration)
	

# สร้างสไปรต์	
func create_sprite() -> void:
	if sprite:
		var inst_sprite = sprite.instantiate()
		add_child(inst_sprite)


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

func _process(_delta):
	process_duration() 
	# process_visual()
	


func process_duration() -> void:
	if caster.bars >= timeout_bars:
		queue_free()


	
func process_visual() -> void:
	if Global.is_alpha_mode:
		modulate.a = 0.75


func get_timeout_bars(_bars: Array, _duration: Array) -> Array:
	var result = []
	for i in range(_bars.size()):
		var sum_result = _bars[i] + _duration[i]
		result.append(sum_result)
	return Lib.fix_bars(result)
