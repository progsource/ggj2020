extends Node

var tween = Tween.new()
onready var taskCard = preload("res://packed/hud/TaskList/TaskCard.tscn")

var isRunning : bool = false

func _ready():
	tween.connect("tween_completed", self, "TweenComplete") 
	add_child(tween)


func _on_StartButton_start_button_pressed():
	isRunning = true

func _on_LevelTimer_level_ended():
	isRunning = false
	clear_child_list()

func _on_Task_recieved(task: CustomerData):
	if !isRunning:
		return

	var list = get_child_count()
	var card = taskCard.instance()
	card.name = str(task)
	card.customer_data = task
	
	if list > 1:
		var lastTask = get_child(list - 1)
		var pos = Vector2(
			lastTask.position.x + 35,
			lastTask.position.y
		)
		card.position = pos

	card.connect("remove_card", self, "_on_TaskCard_remove_card")
	card.connect("task_completed", self, "_on_Task_completed")
	add_child(card)

func _on_TaskCard_remove_card(node):
	tween.interpolate_property(
		node,
		"modulate:a",
		1.0, 0.0, 0.1,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	tween.start()

func _on_Task_completed(node):
	tween.interpolate_property(
		node,
		"modulate:a",
		1.0, 0.0, 0.01,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	tween.interpolate_property(
		node,
		"position:y",
		node.position.y,
		node.position.y - 40,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	tween.start()

# warning-ignore:unused_argument
func TweenComplete(object, key):
	match str(key):
		":modulate:a":
			var customer_data = object.customer_data
			if has_node(object.name):
				remove_child(object)
				if !customer_data.task.taskCompleted:
					customer_data.task.taskFailed = true
				move_Tasks()

func move_Tasks():
	var pos = 0
	for node in self.get_children():
		if node.get_filename() == taskCard.get_path():
			if node.position.x == pos:
				pos +=35
			else:
				tween.interpolate_property(
					node,
					"position:x",
					node.position.x,
					pos,
					1,
					Tween.TRANS_LINEAR,
					Tween.EASE_IN_OUT
				)
				pos += 35
				tween.start()

func clear_child_list():
	for node in self.get_children():
		if node.get_filename() == taskCard.get_path():
			remove_child(node)
