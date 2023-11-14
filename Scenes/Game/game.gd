extends Control

@export var hudLabel: Node
@export var paletteShader: Node

func _process(_delta):
	paletteShader.material.set_shader_parameter("pal_swap_1", Global.palette[0])
	paletteShader.material.set_shader_parameter("pal_swap_2", Global.palette[1])
	set_hud_text()
	
	
func set_hud_text() -> void:
	hudLabel.clear()
	hudLabel.append_text( "TEMPO: %s" % Global.tempo )
