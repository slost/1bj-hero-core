extends AudioStreamPlayer2D
class_name Sound

func _init():
    autoplay = true
    max_distance = 6000
    #func _ready():
    #volume_db += 0.1 * scale.x

func _process(_delta):
    var original_tempo = 60 / 100
    # pitch_scale = original_tempo / Global.seconds_per_bar
    if not playing:
        queue_free()
    if _delta >= Global.seconds_per_bar:
        queue_free()
