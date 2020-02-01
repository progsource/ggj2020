extends Node

signal remove_card(node)

func _on_TaskTimer_task_expired():
	emit_signal("remove_card", self)
