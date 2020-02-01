extends Node

signal remove_card(node)
signal task_completed(node)

var customer_data: CustomerData = null

func _ready():
	if customer_data == null:
		return

	$Devices.display(customer_data.task.device.sprite_index)
	$TaskTimer.time_for_item = customer_data.task.waitingTime

# warning-ignore:unused_argument
func _process(delta):
	if customer_data.task.taskStarted:
		$TaskTimer.get_node("Timer").pause()
	if customer_data.task.taskCompleted:
		_on_task_complete()
	if customer_data.task.taskFailed:
		_on_TaskTimer_task_expired()

func _on_TaskTimer_task_expired():
	emit_signal("remove_card", self)

func _on_task_complete():
	emit_signal("task_completed", self)
