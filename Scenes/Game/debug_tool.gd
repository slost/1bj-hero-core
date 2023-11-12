extends Node

@export var musicH: Node

func _input(_event):
	if Input.is_action_pressed("debug_restart"):
		get_tree().reload_current_scene()
	if Input.is_action_pressed("debug_tempo_increase"):
		musicH.tempo += 1
	if Input.is_action_pressed("debug_tempo_decrease"):
		musicH.tempo -= 1
		
		
