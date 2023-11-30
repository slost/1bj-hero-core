extends Control

@export var playerTempoLabel: RichTextLabel

func _process(_delta):
	playerTempoLabel.text = "TEMPO: " + str(Global.player.music.tempo)
