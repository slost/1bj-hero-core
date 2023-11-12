extends CharacterBody2D
class_name MonsterDummy

@onready var player = $"..".get_node("Player")

enum ENUM_MOVE_TYPE {
	NONE,
	DIRECT,
	ROUNDED
}

@export var move_type:ENUM_MOVE_TYPE = ENUM_MOVE_TYPE.NONE

@export var speed = 200

@export var radius = 300

var _angle = 0

func _ready():
	pass
	

func _process(_delta) -> void:
	match move_type:
		ENUM_MOVE_TYPE.DIRECT:
			var direction = (player.global_position - global_position).normalized()
			velocity = direction * speed
		ENUM_MOVE_TYPE.ROUNDED:
			_angle += _delta
			var offset = player.global_position - Vector2(sin(_angle), cos(_angle)) * radius
			var direction = (offset - global_position).normalized()
			velocity = direction * speed
			
	move_and_slide()
