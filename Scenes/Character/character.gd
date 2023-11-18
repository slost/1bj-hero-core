extends CharacterBody2D
class_name Character

# export
@export var data: Resource = preload("res://Database/Character/player.tres")
@export var inv: Node
@export var animSpr: Node

var is_blink = false
@export var knockbackPower: int = 1600

# onready
@onready var stats: Dictionary = data.stats

var move_speed: float
var sub_bar: int = 1
@onready var bars = Global.bars_init


func _ready() -> void:
	animSpr.play("move_down")
	# scale = Vector2(data.stats.size_scale, data.stats.size_scale)
	scale = Global.SCALE_VEC
	z_index = 2
		
var bar_counter = 1
	
func _physics_process(_delta) -> void:
	move_speed = Lib.get_character_speed(stats.base_speed, scale)
	bars = Lib.process_bars(bars)
	var bars_id = 0
	if bar_counter <= Global.bars[bars_id]:
		pass
		bar_counter += 1
	move_and_slide()
	process_player()
	
func process_player():
	pass	
	
		
func hurt(_source) -> void:
	# ลดเลือด
	knockback(_source.velocity)
	
func knockback(enemyVelocity: Vector2):
	print(is_blink)
	if is_blink:
		return
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()
	# animationPlayer.play("blink")
	# is_blink = true # ฝากแก้ด้วย


func _on_hurt_box_area_entered(area):
	if area.name != "HitBox":
		return
	var source = area.get_parent()
	if source is Projectile:
		if source.caster == self or not source.caster:
			return
		hurt(source)
	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "blink":
		is_blink = false
