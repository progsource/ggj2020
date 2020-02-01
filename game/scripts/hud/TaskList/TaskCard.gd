extends Node

signal remove_card(node)

var task: Task = null

func _ready():
	if task == null:
		return

	$Devices.display(task.device.sprite_index)
	$TaskTimer.time_for_item = task.waitingTime

func _on_TaskTimer_task_expired():
	emit_signal("remove_card", self)
