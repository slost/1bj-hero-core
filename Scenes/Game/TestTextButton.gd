extends Button

var text_dialog: Array[String] = [
	"Test Text",
	"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type",
	"specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
	"ทดสอบข้อความ"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	DialogManger.start_dialog( Global.map.get_node("Player").global_position, text_dialog)
	#DialogManger.start_dialog(Vector2(), text_dialog, true)
