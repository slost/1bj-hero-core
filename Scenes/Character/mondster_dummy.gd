extends CharacterBody2D

@onready var player = $"..".get_node("Player")

var speed = 200


func _ready():
	pass
	

func _process(_delta) -> void:
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
