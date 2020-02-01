extends Node

signal remove_card(node)

var task: Task = null

func _ready():
	var icon = get_node("TaskIcon")
	icon.task = task
	icon.add_icon()

func _on_TaskTimer_task_expired():
	emit_signal("remove_card", self)
