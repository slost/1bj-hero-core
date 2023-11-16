extends CharacterBody2D

# export
@export var data: Resource = preload("res://Database/Character/player.tres")
@export var inv: Node
@export var animSpr: Node

# onready
@onready var stats: Dictionary = data.stats

var move_speed: float
var bars: int = 1


func _ready() -> void:
	animSpr.play("move_down")
	# scale = Vector2(data.stats.size_scale, data.stats.size_scale)
	scale = Global.SCALE_VEC
	z_index = 2
	Global.player = self
	TurnManager.add_turn(self)


# การควบคุม
func get_input() -> void:
	move_speed = Lib.get_character_speed(stats.base_speed, scale)
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if not inv.has_node("FreeMovement"):
		if abs(input_direction.x) > abs(input_direction.y):
			input_direction.y = 0
		else:
			input_direction.x = 0
	velocity = input_direction * move_speed

func play_animation():
	if Input.is_action_pressed("move_left"):
		animSpr.play("move_left")
	elif Input.is_action_pressed("move_down"):
		animSpr.play("move_down")
	elif Input.is_action_pressed("move_right"):
		animSpr.play("move_right")
	elif Input.is_action_pressed("move_up"):
		animSpr.play("move_up")
	else:
		animSpr.set_frame(0)
		animSpr.stop()
		
func _physics_process(_delta) -> void:
	play_animation()
	if bars <= Global.bars:
		get_input()
		bars += 1
	move_and_slide()
