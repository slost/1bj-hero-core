extends Button

var text_dialog: Array[String] = [
	"Pause the Game. \nPress SPACE BAR to continue."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	#DialogManger.start_dialog( Global.map.get_node("Player").position, text_dialog)
	DialogManger.start_dialog(Vector2(), text_dialog, true)
