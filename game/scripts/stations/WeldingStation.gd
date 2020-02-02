extends KinematicBody2D

signal welding_finished(slot_index)

var held_item : int = -1
const SECONDS_TO_WELD = 5.0
var left_welding_time = 0.0

func _ready():
	$Items.connect("item_exploded", self, "_on_item_exploded")
	$Timer.connect("timeout", self, "_on_timeout")
	_update_progress_bar()

func _update_progress_bar():
	var percentage = left_welding_time / SECONDS_TO_WELD
	$StationProgressBar.update_progress(percentage)
	$StationProgressBar.visible = percentage > 0

func hold_item(var index : int, var slot_index : int):
	$Items.display(index)
	$Items.set_slot(slot_index)
	held_item = index
	left_welding_time = SECONDS_TO_WELD
	_update_progress_bar()

func remove_item():
	$Timer.stop()
	held_item = -1
	$Items.hide_items()
	$Items.set_slot(-1)

func get_slot_index() -> int :
	return $Items.slot

func _on_item_exploded(var slot_index):
	held_item = -1

func start_welding():
	_update_progress_bar()
	$Timer.start()
	$Timer.paused = false

func stop_welding():
	$Timer.paused = true

func _on_timeout():
	left_welding_time -= 1
	print(left_welding_time)
	if left_welding_time <= 0:
		$Timer.stop()
		emit_signal("welding_finished", $Items.slot)
	_update_progress_bar()
		
