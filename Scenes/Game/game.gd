extends Control

@export var hudLabel: Node
@export var paletteShader: Node
@export var background: Node

func _process(_delta):
	background.color = Global.palette[1]
	#paletteShader.material.set_shader_parameter("pal_swap_1", Global.palette[0])
	# paletteShader.material.set_shader_parameter("pal_swap_2", Global.palette[1])
	# paletteShader.material.set_shader_parameter("pal_swap_2", Color.WHITE)
	set_hud_text()
	# ProjectSettings.set_setting("rendering/environment/default_clear_color", Global.palette[1])
	
func set_hud_text() -> void:
	hudLabel.clear()
	hudLabel.append_text( "TEMPO: %s" % Global.tempo )
