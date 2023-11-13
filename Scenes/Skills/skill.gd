extends StaticBody2D

var timer: float
var size_scale: int = 4

func _init():
	scale = Vector2(size_scale, size_scale)
	add_collision_exception_with(Global.player)

func _process(_delta) -> void:
	scale -= Vector2(1, 1)
	
	if Global.is_alpha_mode:
		$Sprite2D.modulate.a = 0.5
	
	timer += 1
	
	
	if timer >= 60.0 or scale <= Vector2(0, 0):
		queue_free()
		
