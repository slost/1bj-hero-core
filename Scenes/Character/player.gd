extends CharacterBody2D

# export
@export var stats: Node
@export var inv: Node

# onready
@onready var speed = stats.base_speed


# การควบคุม
func get_input() -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if !has_node("Inventory/FreeMovement"):
		if abs(input_direction.x) > abs(input_direction.y):
			input_direction.y = 0
		else:
			input_direction.x = 0
	velocity = input_direction * speed


func _physics_process(_delta) -> void:
	get_input()
	var size_scale = stats.size_scale
	scale = Vector2(size_scale, size_scale)
	move_and_slide()
