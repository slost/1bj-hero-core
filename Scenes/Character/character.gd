extends CharacterBody2D
class_name Character

# export
@export var data: Resource = preload("res://Database/Character/player.tres")
@export var animSpr: Node

@export_category("Stats")
@export var max_hp: int = 9999
@export var max_mp: int = 9999
## ดาเมจของกระสุนจะคูณด้วย 0.1 ของค่า strength
@export var strength: int = 99

var is_blink = false
var knockback_power: int = 1000

# onready
@onready var stats: Dictionary = data.stats

var move_speed: float

# Music Stuffs
var music = null
var bars = [1,1,1, 0.0]

var cap_stats = 9999
var is_cap_stats: bool = false

@onready var hp = max_hp


func _ready() -> void:
	z_index = 2
	# scale = Global.SCALE_VEC * stats.scale_multiplier

	music = Music.new()
	music.tempo = 100
	add_child(music)
	bars = music.bars
	
	ready_character()
		

func init_stat() -> void:
	pass

var bar_counter = 1
	
func _physics_process(_delta) -> void:
	if Global.is_ready:
		music.play = true

	if DialogManger.is_dialog_active:
		return
	move_speed = Lib.get_character_speed(1, scale)
	var bars_id = 1
	if bar_counter > 4:
		bar_counter = 0
	if bar_counter <= bars[bars_id]:
		on_bar_change()
		bar_counter += 1
	move_and_slide()
	process_player()
	if hp <= 0:
		on_death()

	if is_cap_stats:
		if max_hp > cap_stats:
			max_hp = cap_stats
	
	
func on_death():
	if self is Monster:
		queue_free()
		return
	if self is Player:
		queue_free()
		return
	visible = false
	
func on_bar_change():
	pass
	
func process_player():
	pass	
	
func ready_character():
	pass


func hurt(_source) -> void:
	# ลดเลือด
	hp -= _source.damage * (_source.caster.strength * 0.1)
	knockback(_source)
	

func knockback(_source: Node):
	if is_blink:
		return
	# knockbac kDirection
	velocity = (_source.velocity - velocity).normalized() * (_source.knockback_power * 10)
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
