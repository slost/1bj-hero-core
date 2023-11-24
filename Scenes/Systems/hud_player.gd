extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Panel/RichTextLabel.clear()
	$Panel/RichTextLabel.append_text("[center]Knight LV 99\n \
HP %s/%s\n\
MP 9999/9999[/center] \
	" % [Global.player.hp,Global.player.max_hp])
