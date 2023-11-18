## กระสุนหรือพลังที่เกิดจากสกิล
extends Area2D
class_name Projectile


const BASE_SPEED: int = 1
## ระยะทางที่จะพุ่งไป (สามารถกำหนดได้ใน Skill Pattern)
var direction: Vector2
## เป้าหมายที่จะพุ่งไปหา
@export var target: Node
## ล็อคเป้าหมายหรือไม่
@export var target_lock: bool = false 
## ขนาดที่จะคูณ
@export var scale_multiply: int = 1


var timer: float
var delta: float
var caster: Node
var sound_file: String
var velocity: Vector2


func _ready() -> void:
	if caster:
		scale = caster.scale
	scale *= scale_multiply
	spawn_sound()


class Sound:
	extends AudioStreamPlayer2D
	func _init():
		stream = load("res://Assets/Audio/Gameplay/kick.tres")
		autoplay = true
		max_distance = 6000
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
	Global.musicH.add_child(sound)

	
func _physics_process(_delta) -> void:
	delta = _delta
	if target_lock: # ล็อคเป้าอ๊ะเปล่า
		direction = (target.global_position - global_position).normalized()
	var speed = Lib.get_character_speed(BASE_SPEED, scale) \
		* Global.seconds_per_bar * 0.25
	# scale -= scale * ( 60 / Global.tempo ) * 0.1
	# if target:
		# velocity = target * speed
	velocity = direction * speed
	# process_visual()
	translate(velocity)
	process_duration() 
	
	
func process_duration() -> void:
	timer += delta
	if timer >= Global.seconds_per_bar:
		queue_free()
	
func process_visual() -> void:
	if Global.is_alpha_mode:
		modulate.a = 0.75



