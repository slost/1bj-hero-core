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
	stats.base_speed = 2


# การควบคุม
func get_input() -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if not has_node("Wings"):
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
	process_item_power()

func process_item_power():
	if get_node("Heal"):
		hp+= round(max_hp * 0.01)

func on_bar_change():
	get_input()
	
	
func on_death():
	print("YOU DIED")
	# เข้าฉากเกมโอเวอร์
	
func get_item_amount() -> int:
	var amount = 0
	for i in get_children():
		if i is Item:
			amount += 1
	return amount
			

func lose_all_items():
	for i in get_children():
		if i is Item:
			i.queue_free()
	print_debug("YOU LOSE ALL ITEMS!")
	
func hurt(_source) -> void:
	# ลดเลือด
	hp -= _source.damage * (_source.caster.strength * 0.1)
	lose_random_item()
	knockback(_source)

func lose_random_item():
	for i in get_children():
		if i is Item:
			i.queue_free()
			return
	print_debug("YOU LOSE A ITEM!")
