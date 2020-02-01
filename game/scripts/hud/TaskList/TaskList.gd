extends Node

var tween = Tween.new()
onready var taskCard = preload("res://packed/hud/TaskList/TaskCard.tscn")

var timer_raw = 0
var timer = 0
var count = 1

func _ready():
	tween.connect("tween_completed", self, "TweenComplete") 
	add_child(tween)

func _process(delta):
	timer_raw += delta
	timer = round(timer_raw)

	if timer > 2:
		_on_Task_recieved("test " + str(count))
		count += 1
		timer_raw = 0

func _on_Task_recieved(task):
	print("Recieved Task " + task)
	var card = taskCard.instance()
	card.name = task
	card.connect("remove_card", self, "_on_TaskCard_remove_card")
	card.get_child(1).time_for_item = rand_range(3, 9)
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
	print('Removing Node ' + object.name)
	remove_child(object)
