extends Node

var skill_path = "res://Scenes/Skills/skill.tscn"
var bars: int = 1
var is_on_cooldown: bool = false

func _process(_delta):
	
	
	if not is_on_cooldown:
		if Global.bars >= bars:
				release_skill("kick", "middle")
		if Global.bars % 2 == 0:
				release_skill("snare", "middle")
		bars += 1
		
	
		
func release_skill(_skill: String, direction: String):
	var kick = load(skill_path).instantiate()
	var snare = load(skill_path).instantiate()
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
	snare.transform.origin = $"../..".transform.origin +  Vector2(0, 16 *4) * 4
	if _skill == "snare":
		$"..".add_child(snare)
	$"..".add_child(kick)
