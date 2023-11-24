extends CharacterBody2D
class_name Character

# export
@export var data: Resource = preload("res://Database/Character/player.tres")
@export var animSpr: Node

var is_blink = false
@export var knockback_power: int = 100

# onready
@onready var stats: Dictionary = data.stats

var move_speed: float
var sub_bar: int = 1
@onready var bars = Global.BARS_INIT

var max_hp = 999999
var strength = 99

@onready var hp = max_hp


func _ready() -> void:
	animSpr.play("move_down")
	scale = Global.SCALE_VEC * stats.scale_multiplier
	z_index = 2
		
func init_stat() -> void:
	pass

var bar_counter = 1
	
func _physics_process(_delta) -> void:
	if DialogManger.is_dialog_active:
		return
	move_speed = Lib.get_character_speed(stats.base_speed, scale)
	bars = Lib.process_bars(bars)
	var bars_id = 1
	if bar_counter > 4:
		bar_counter = 0
	if bar_counter <= Global.bars[bars_id]:
		on_bar_change()
		bar_counter += 1
	move_and_slide()
	process_player()
	if hp <= 0:
		on_death()
	
func on_death():
	visible = false
	
func on_bar_change():
	pass
	
func process_player():
	pass	
	
func hurt(_source) -> void:
	# ลดเลือด
	hp -= _source.damage * (_source.caster.strength * 0.1)
	knockback(_source)
	
func knockback(_source: Node):
	if is_blink:
		return
	# knockbac kDirection
	velocity = (_source.velocity - velocity).normalized() * (knockback_power)
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
