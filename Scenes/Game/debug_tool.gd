extends Node
func _input(event):
	if Input.is_action_pressed("debug_restart"):
		get_tree().reload_current_scene()
