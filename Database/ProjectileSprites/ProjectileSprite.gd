@tool 
extends AnimatedSprite2D
class_name ProjectileSprite

func _init():
	set("sprite_frames", load("res://Database/ProjectileSprites/ProjectileSprite.tres"))
