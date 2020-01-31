extends Sprite

signal level_ended

var leftTime = 60

func _ready():
	#connect("timeout", $Timer, "_on_timer_timeout")
	pass

func _process(delta):
	pass


func _on_StartButton_start_button_pressed():
	$Label.text = get_time_as_time_string(leftTime)
	$Timer.start()


func _on_Timer_timeout():
	leftTime -= 1
	$Label.text = get_time_as_time_string(leftTime)
	if leftTime == 0:
		$Timer.stop()
		emit_signal("level_ended")

func get_time_as_time_string(time : int) -> String:
	var minutes = floor(time / 60);
	var seconds = time % 60;
	return "%02d:%02d" % [minutes, seconds]
