extends StaticBody2D

var timer: float
var size_scale: int = 4

func _init():
	scale = Vector2(size_scale, size_scale)

func _process(_delta) -> void:
	if Global.is_alpha_mode:
		$Sprite2D.modulate.a = 0.5
	
	add_collision_exception_with(Global.player)
	timer += 1
	
	if timer >= 60.0:
		queue_free()
		
