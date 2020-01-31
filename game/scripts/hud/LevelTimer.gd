extends Sprite

signal level_ended

var leftTime = 60

func _ready():
	#connect("timeout", $Timer, "_on_timer_timeout")
	pass

func _process(delta):
	pass


func _on_StartButton_start_button_pressed():
	$Timer.start()


func _on_Timer_timeout():
	leftTime -= 1
	$Label.text = String(leftTime)
	if leftTime == 0:
		$Timer.stop()
		emit_signal("level_ended")
