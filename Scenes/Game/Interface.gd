extends Control

@export var playerTempoLabel: RichTextLabel
@export var monsterTempoLabel: RichTextLabel

func _process(_delta):
	var player = Global.player
	var player_tempo = "[center]TEMPO: " + str(player.music.tempo)
	if Global.player.music:
		playerTempoLabel.text = player_tempo + "\n" + Lib.get_bars_string(player.bars) 


