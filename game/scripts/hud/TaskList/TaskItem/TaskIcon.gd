extends Node

var task: Task = null

onready var mobile = preload("res://packed/items/Mobile.tscn")

func add_icon():
	if task == null:
		return

	var icon
	var isMobile = task.device.sprite_index % 2
	match isMobile:
		1:
			icon = mobile.instance()
			add_child(icon)
