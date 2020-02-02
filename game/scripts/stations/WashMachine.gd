extends KinematicBody2D

signal washing_finished(machine_id)

var held_item : int = -1
const washing_time = 4.0
var left_washing_time = 0.0
var index = -1
var washing: bool = false

func _ready():
# warning-ignore:return_value_discarded
	$Timer.connect("timeout", self, "_on_timeout")
	_update_progress_bar()

func hold_item(var item_index : int, var slot_index : int):
	print("%d should be shown" % item_index)
	print("from slot %d" % slot_index)
	$Items.display(item_index)
	$Items.slot = slot_index
	$Items.modulate = Color(1, 1, 1, 0.7)
	held_item = item_index

func remove_item():
	$Items.hide_items()
	$Items.slot = -1
	$Items.modulate = Color(1, 1, 1, 1)
	held_item = -1

func explode_item():
	$Items.explode()
	$Items.slot = -1
	held_item = -1
	$Timer.stop()

func _on_player_started_washing(var station_index):
	if station_index != index:
		return
	print("start washing %d" % station_index)
	left_washing_time = washing_time
	washing = true
	$Timer.start()

func _on_timeout():
	left_washing_time -= 1
	if left_washing_time <= 0:
		if washing:
			emit_signal("washing_finished", index)
		washing = false
	_update_progress_bar()

func _update_progress_bar():
	var percentage = left_washing_time / washing_time
	$StationProgressBar.update_progress(percentage)
	$StationProgressBar.visible = percentage > 0

func get_slot_index() -> int :
	return $Items.slot
