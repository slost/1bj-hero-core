extends Control
class_name Game

## Nodes
@export var paletteShader: Node
@export var background: Node
@export var map: Node2D
@export var screenAnimation: AnimationPlayer

@export_category("Title")
@export var titleBG: Node
@export var titleBG_bottom: Node
@export var titleLabel: Node
@export var titlePressAnyKey: Node
@export var titlePressAnyKeyTimer: Timer

var current_state = null
var is_wait_for_press_any_key = false

@export_category("Load")
@export var loadLabel1: Node
@export var loadLabel2: Node
@export var loadControl: Node
@export var loadBtn: Node
@export var loadBtn_cant:Array[Node]

func _ready():
	map.visible = false
	titleBG.visible = false
	titleBG_bottom.visible = false
	titleLabel.visible = false
	titlePressAnyKey.visible = false
	titlePressAnyKeyTimer.timeout.connect(_on_anykey_timeout)
	#----
	loadLabel1.visible = false
	loadLabel2.visible = false
	loadControl.visible = false
	loadBtn.pressed.connect(_on_button_load_pressed)
	for i in loadBtn_cant:
		i.pressed.connect(_on_button_load_cant_pressed)

func _process(_delta):
	background.color = Global.palette[1]
	#paletteShader.material.set_shader_parameter("pal_swap_1", Global.palette[0])
	# paletteShader.material.set_shader_parameter("pal_swap_2", Global.palette[1])
	# paletteShader.material.set_shader_parameter("pal_swap_2", Color.WHITE)
	# set_hud_text()
	# ProjectSettings.set_setting("rendering/environment/default_clear_color", Global.palette[1])
	if current_state != Global.cureent_state:
		update_state_to(Global.cureent_state)
	if current_state == Global.GAME_SCREEN.TITLE:
		update_title_state()
	
func set_hud_text() -> void:
	pass
	# hudLabel.clear()
	#hudLabel.append_text( "TEMPO: %s" % Global.tempo )

# คำสั่งใช้ตอนเปลี่ยนเกม state
func update_state_to(new_state):
	var old_state = current_state
	# คำสั่งที่อาจจะใช้ เพื่อเฟดซีนเก่าออก
	match old_state:
		Global.GAME_SCREEN.TITLE:
			screenAnimation.play("fadeout_title")
			await screenAnimation.animation_finished
		Global.GAME_SCREEN.LOAD:
			screenAnimation.play("fadeout_load")
			await screenAnimation.animation_finished
	
	# คำสั่งที่ใช้เมื่อเริ่มซีนใหม่
	match new_state:
		Global.GAME_SCREEN.TITLE:
			screenAnimation.play("fadein_title")
			await screenAnimation.animation_finished
			is_wait_for_press_any_key = true
			titlePressAnyKeyTimer.start()
		Global.GAME_SCREEN.LOAD:
			screenAnimation.play("fadein_load")
			await screenAnimation.animation_finished
		Global.GAME_SCREEN.GAME:
			map.visible = true
	current_state = new_state

func update_title_state():
	# อัพเดตอะไรก็ได้
	pass

# ทำให้ตัว PressAnyKey กระพริบ
func _on_anykey_timeout():
	if current_state == Global.GAME_SCREEN.TITLE && is_wait_for_press_any_key:
		titlePressAnyKey.visible = !titlePressAnyKey.visible
		titlePressAnyKeyTimer.start()

func _input(event):
	# รับค่า PressAnyKey
	if current_state == Global.GAME_SCREEN.TITLE && is_wait_for_press_any_key:
		if event is InputEventKey:
			if event.pressed:
				is_wait_for_press_any_key = false
				titlePressAnyKey.visible = false
				Global.cureent_state = Global.GAME_SCREEN.LOAD

func _on_button_load_pressed():
	# เล่นเสียงตกลง
	
	Global.cureent_state = Global.GAME_SCREEN.GAME

func _on_button_load_cant_pressed():
	# เล่นเสียง กดโหลดไม่ได้
	pass
