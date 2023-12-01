extends Control

@export var playerTempoLabel: RichTextLabel
@export var playerHud: Node
@export var monsterTempoLabel: RichTextLabel
@export var monsterHud: Node


func _process(_delta):
	if Global.is_ready:
		update_tempo_label()
		update_hud()
	else:
		playerTempoLabel.text = ""
		monsterTempoLabel.text = ""
		playerHud.get_node("Panel/RichTextLabel").text = ""
		monsterHud.get_node("Panel/RichTextLabel").text = ""

func update_tempo_label() -> void:
	var player = Global.player
	var player_tempo = "[center]TEMPO: " + str(player.music.tempo)
	if Global.player.music:
		playerTempoLabel.text = player_tempo + "\n" + Lib.get_bars_string(player.bars) 
	var boss = Global.boss
	var boss_tempo = "[center]TEMPO: " + str(boss.music.tempo)
	if Global.boss.music:
		monsterTempoLabel.text = boss_tempo + "\n" + Lib.get_bars_string(boss.bars)

func update_hud() -> void:
	var playerHudLabel = playerHud.get_node("Panel/RichTextLabel")
	playerHudLabel.clear()
	playerHudLabel.append_text("[center]Knight LV 99\n \
	HP %s/%s\n\
	MP 9999/9999[/center] \
		" % [Global.player.hp, Global.player.max_hp])
	var monsterHudLabel = monsterHud.get_node("Panel/RichTextLabel")
	monsterHudLabel.clear()	
	monsterHudLabel.append_text("[center]Monster LV 99\n \
	HP %s/%s\n \
	MP 9999/9999[/center] \
	" % [Global.boss.hp, Global.boss.max_hp])		