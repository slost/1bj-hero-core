extends Control

func _process(_delta):
	$SubViewportContainer.material.set_shader_parameter("pal_swap_1", Global.palette[0])
	$SubViewportContainer.material.set_shader_parameter("pal_swap_2", Global.palette[1])
