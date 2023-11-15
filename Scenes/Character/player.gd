extends CharacterBody2D

# export
@export var data: Resource = preload("res://Database/Character/player.tres")
@export var inv: Node

# onready
@onready var stats: Dictionary = data.stats

var speed: float


func _ready() -> void:
	scale = Global.SCALE_VEC
	z_index = 2
	Global.player = self


# การควบคุม
func get_input() -> void:
	speed = Lib.get_character_speed(stats.base_speed, scale)
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if not inv.has_node("FreeMovement"):
		if abs(input_direction.x) > abs(input_direction.y):
			input_direction.y = 0
		else:
			input_direction.x = 0
	velocity = input_direction * speed


func _physics_process(_delta) -> void:
	get_input()
	move_and_slide()
