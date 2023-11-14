extends StaticBody2D

var timer: float


func _init():
	scale = Global.scale
	

func _process(_delta) -> void:
	# scale -= scale * ( 60 / Global.tempo ) * 0.1
	#if Global.is_alpha_mode:
	#	$Sprite2D.modulate.a = 0.5
	
	timer += 1
	
	if timer >= ( 6000 / Global.tempo ):
		queue_free()
		
