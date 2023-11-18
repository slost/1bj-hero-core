extends Character
class_name Player

# export


# onready
@onready var animationPlayer = $AnimationPlayer


func _ready() -> void:
	animSpr.play("move_down")
	# scale = Vector2(data.stats.size_scale, data.stats.size_scale)
	scale = Global.SCALE_VEC
	z_index = 2
	Global.player = self
	TurnManager.create_turn_queue($"..")


# การควบคุม
func get_input() -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if not inv.has_node("FreeMovement"):
		if abs(input_direction.x) > abs(input_direction.y):
			input_direction.y = 0
		else:
			input_direction.x = 0
	velocity = input_direction * move_speed

func play_animation():
	if Input.is_action_pressed("move_left"):
		animSpr.play("move_left")
	elif Input.is_action_pressed("move_right"):
		animSpr.play("move_right")
	elif Input.is_action_pressed("move_down"):
		animSpr.play("move_down")
	elif Input.is_action_pressed("move_up"):
		animSpr.play("move_up")
	else:
		animSpr.set_frame(0)
		animSpr.stop()
		
func process_player():
	var bars_id = 0
	play_animation()
		
func on_bar_change():
	get_input()
	
func on_death():
	print("YOU DIED")
	# เข้าฉากเกมโอเวอร์
		
"""func _physics_process(_delta) -> void:
	bars = Lib.process_bars(bars)
	play_animation()
	var bars_id = 0
	move_and_slide()"""
