extends Node

var tween = Tween.new()
onready var taskCard = preload("res://packed/hud/TaskList/TaskCard.tscn")

var timer_raw = 0
var timer = 0
var count = 1

var isRunning : bool = false

func _ready():
	tween.connect("tween_completed", self, "TweenComplete") 
	add_child(tween)

func _on_StartButton_start_button_pressed():
	isRunning = true

func _on_LevelTimer_level_ended():
	isRunning = false
	clear_child_list()

func _on_Task_recieved(task):
	if !isRunning:
		return

	var list = get_child_count()
	var card = taskCard.instance()
	card.name = str(task)
	card.task = task
	
	if list > 1:
		var lastTask = get_child(list - 1)
		var pos = Vector2(
			lastTask.position.x + 50,
			lastTask.position.y
		)
		card.position = pos

	card.connect("remove_card", self, "_on_TaskCard_remove_card")
	card.get_child(1).time_for_item = rand_range(6, 6)
	print("Time for Item " + str(card.get_child(1).time_for_item))
	add_child(card)

func _on_TaskCard_remove_card(node):
	tween.interpolate_property(
		node,
		"modulate:a",
		1.0, 0.0, 0.1,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT
	)
	tween.start()

# warning-ignore:unused_argument
func TweenComplete(object, key):
	match str(key):
		":modulate:a":
			print('Removing Node ' + object.name)
			remove_child(object)
			move_Tasks()

func move_Tasks():
	for node in self.get_children():
		if node.get_filename() == taskCard.get_path():
			tween.interpolate_property(
				node,
				"position:x",
				node.position.x,
				node.position.x - 50,
				1,
				Tween.TRANS_CUBIC,
				Tween.EASE_IN_OUT
			)
			tween.start()

func clear_child_list():
	for node in self.get_children():
		if node.get_filename() == taskCard.get_path():
			remove_child(node)
