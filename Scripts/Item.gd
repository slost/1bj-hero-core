extends Node

var skill = "res://Scenes/Skills/skill.tscn"
var bars: int = 1
var is_on_cooldown: bool = false

func _process(_delta):
	
	
	if Global.bars >= bars:
		if not is_on_cooldown:
			release_skill("middle")
			bars += 1
	
		
func release_skill(direction: String):
	var kick = load(skill).instantiate()
	var dir
	match direction:
		"up":
			dir = Vector2(0, 16 *4)
		"down":
			dir = Vector2(0, -16 *4)
		"left":
			dir = Vector2(16 *4, 0)
		"right":
			dir = Vector2(-16 *4, 0)
		"middle":
			dir = Vector2(0, 0)
	kick.scale = Vector2(16, 16)
	kick.transform.origin = $"../..".transform.origin + dir
	$"..".add_child(kick)
