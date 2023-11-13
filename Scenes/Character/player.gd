extends CharacterBody2D

# export
@export var base_speed: int
@export var size_scale: int
@export var stats: Node
@export var inv: Node

# onready
var speed: float


# การควบคุม
func get_input() -> void:
	speed = ( base_speed * 100 * size_scale ) * 0.5
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if not inv.has_node("FreeMovement"):
		if abs(input_direction.x) > abs(input_direction.y):
			input_direction.y = 0
		else:
			input_direction.x = 0
	velocity = input_direction * speed


func _physics_process(_delta) -> void:
	get_input()
	scale = Vector2(size_scale, size_scale)
	move_and_slide()
