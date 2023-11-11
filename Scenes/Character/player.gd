extends CharacterBody2D

# export
@export var stats: Node

# onready
@onready var speed = stats.base_speed


# การควบคุม
func get_input() -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed


func _physics_process(_delta) -> void:
	get_input()
	move_and_slide()
