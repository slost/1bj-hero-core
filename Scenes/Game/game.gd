extends Control

@export var paletteShader: Node
@export var background: Node

# ----------------------------------
#  Title
# ---------------------------------- 
@onready var TitleBG = $Control/Screen/SubViewport/PaletteShader/SubViewport/TtileCanvasLayer/TitleBG
@onready var TitleBG_Bottom = $Control/Screen/SubViewport/PaletteShader/SubViewport/TtileCanvasLayer/TitleBG_bottom
@onready var TitleLable = $Control/Screen/SubViewport/PaletteShader/SubViewport/TtileCanvasLayer/TitleLabel
@onready var TitlePressAnyKey = $Control/Screen/SubViewport/PaletteShader/SubViewport/TtileCanvasLayer/PressAnyKeyLabel
@onready var TitlePressAnyKeyTimer:Timer = $Control/Screen/SubViewport/PaletteShader/SubViewport/TtileCanvasLayer/PressAnyKeyLabel/Timer
# ----------------------------------

@onready var MapObj = $Control/Screen/SubViewport/PaletteShader/SubViewport/Map

@onready var ScreenAnimation:AnimationPlayer = $Control/Screen/AnimationScreen

var current_state = null
var is_wait_for_press_any_key = false

func _ready():
	MapObj.visible = false
	TitleBG.visible = false
	TitleBG_Bottom.visible = false
	TitleLable.visible = false
	TitlePressAnyKey.visible = false
	TitlePressAnyKeyTimer.timeout.connect(_on_anykey_timeout)

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
			ScreenAnimation.play("fadeout_title")
			await ScreenAnimation.animation_finished
	
	# คำสั่งที่ใช้เมื่อเริ่มซีนใหม่
	match new_state:
		Global.GAME_SCREEN.TITLE:
			ScreenAnimation.play("fadein_title")
			await ScreenAnimation.animation_finished
			is_wait_for_press_any_key = true
			TitlePressAnyKeyTimer.start()
		Global.GAME_SCREEN.GAME:
			MapObj.visible = true
	current_state = new_state

func update_title_state():
	# อัพเดตอะไรก็ได้
	pass

# ทำให้ตัว PressAnyKey กระพริบ
func _on_anykey_timeout():
	if current_state == Global.GAME_SCREEN.TITLE && is_wait_for_press_any_key:
		TitlePressAnyKey.visible = !TitlePressAnyKey.visible
		TitlePressAnyKeyTimer.start()

func _input(event):
	# รับค่า PressAnyKey
	if current_state == Global.GAME_SCREEN.TITLE && is_wait_for_press_any_key:
		if event is InputEventKey:
			if event.pressed:
				is_wait_for_press_any_key = false
				TitlePressAnyKey.visible = false
				Global.cureent_state = Global.GAME_SCREEN.GAME
