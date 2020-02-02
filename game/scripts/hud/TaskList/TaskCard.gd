extends Node

signal remove_card(node)
signal task_completed(node)

var customer_data: CustomerData = null

func _ready():
	if customer_data == null:
		return

	$Devices.display(customer_data.task.device.sprite_index)
	$Requirements.requirements = customer_data.task.requirements
	$Requirements.start()
	$TaskTimer.time_for_item = customer_data.task.waitingTime
	$TaskTimer.start()

# warning-ignore:unused_argument
func _process(delta):
	if customer_data.task.taskStarted:
		customer_data.task.startedAt = $TaskTimer.left_time
		$TaskTimer.get_node("Timer").paused = true
	if customer_data.task.taskCompleted:
		_on_task_complete()
	if customer_data.task.taskFailed:
		_on_TaskTimer_task_expired()

func _on_TaskTimer_task_expired():
	emit_signal("remove_card", self)

func _on_task_complete():
	emit_signal("task_completed", self)
