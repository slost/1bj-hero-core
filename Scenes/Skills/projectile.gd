## กระสุนหรือพลังที่เกิดจากสกิล
extends CharacterBody2D

var timer: float
const BASE_SPEED: int = 4
var direction: Vector2
var delta: float

func _init():
	add_collision_exception_with(self)
	scale = Global.SCALE_VEC
	direction = Dir.N
	

func _physics_process(_delta) -> void:
	delta = _delta
	var speed = Lib.get_character_speed(BASE_SPEED, scale)
	# scale -= scale * ( 60 / Global.tempo ) * 0.1
	if Global.is_alpha_mode:
		modulate.a = 0.75
	velocity = direction * speed
	move_and_slide()
	process_duration() 
		

func process_duration() -> void:
	timer += delta
	if timer >= Global.seconds_per_bar:
		queue_free()
