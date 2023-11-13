extends CharacterBody2D

# export
@export var data: Resource = preload("res://Database/Character/player_db.tres")
@export var inv: Node

# onready
@onready var stats: Dictionary = data.stats

var speed: float


func _ready():
	scale = Global.scale
	z_index = 2
	Global.player = self


# การควบคุม
func get_input() -> void:
	speed = ( stats.base_speed * 100 * stats.size_scale ) * 0.5
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
