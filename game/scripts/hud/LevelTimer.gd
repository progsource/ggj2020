extends Sprite

signal level_ended

export var time_per_level : int = 120
var left_time : int = 0

#func _ready():
#	pass

#func _process(delta):
#	pass

func _on_StartButton_start_button_pressed():
	$Label.text = get_time_as_time_string(left_time)
	left_time = time_per_level
	$Timer.start()

func _on_Timer_timeout():
	left_time -= 1
	$Label.text = get_time_as_time_string(left_time)
	if left_time == 0:
		$Timer.stop()
		emit_signal("level_ended")

func get_time_as_time_string(time : int) -> String:
	var minutes = floor(float(time) / 60);
	var seconds = time % 60;
	return "%02d:%02d" % [minutes, seconds]
