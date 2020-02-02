extends Node

signal task_expired

var time_for_item : int = 120
var left_time : int = 0


# Called when the node enters the scene tree for the first time.
func start():
	$ProgressBar.value = 100
	left_time = time_for_item
	$Timer.start()

func _on_Timer_timeout():
	left_time -= 1

	# warning-ignore:integer_division
	$ProgressBar.value = left_time * 100 / time_for_item
	if left_time == 0:
		$Timer.stop()
		emit_signal("task_expired")
