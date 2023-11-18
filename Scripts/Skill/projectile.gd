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
var damage:int = 10

var sound_path: String
var timer: float
var delta: float
var caster: Node
var sound_file: String
var velocity: Vector2


func _ready() -> void:
	if caster:
		scale = caster.scale
	scale *= scale_multiplier
	spawn_sound()

	
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


class Sound:
	extends AudioStreamPlayer2D
	func _init():
		autoplay = true
		max_distance = 6000
	func _ready():
		volume_db += 0.16 * scale.x
	func _process(_delta):
		if not playing:
			queue_free()
	

# สร้าง AudioStreamPlayer2D ในโหนด MusicHanlder
func spawn_sound():
	var sound = Sound.new()
	if caster == Global.player:
		sound.bus = "Player"
	else:
		sound.bus = "Monster"
	sound.global_position = self.global_position
	sound.scale = self.scale
	if sound_path:
		sound.stream = load(sound_path) 
	Global.musicH.add_child(sound)


