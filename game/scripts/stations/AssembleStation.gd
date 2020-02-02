extends KinematicBody2D

signal assembling_finished
var held_item : int = -1 setget set_held_item
const welding_time = 4.0
var left_welding_time = 0.0
var index = -1

func set_held_item(var device_index : int) -> void :
	print("AssembleStation(%d).set_held_item %d" % [index, device_index])
	held_item = device_index

func _ready():
# warning-ignore:return_value_discarded
	$Timer.connect("timeout", self, "_on_timeout")
	$Items.connect("item_exploded", self, "_on_item_exploded")
	_update_progress_bar()

func hold_item(var device_index : int, var slot_index : int):
	print("AssembleStation(%d).hold_item: device_index %s, slot_index %s" % [index, device_index, slot_index])
	$Items.display(device_index)
	$Items.set_slot(slot_index)
	held_item = device_index

func explode_item():
	$Items.explode()
	$Items.set_slot(-1)
	held_item = -1
	$Timer.stop()

func remove_item():
	held_item = -1
	$Items.hide_items()
	$Items.set_slot(-1)

func _on_player_started_assembling(var station_index):
	if station_index != self.index:
		return
	left_welding_time = welding_time
	$Timer.start()

func _on_player_stopped_assembling():
	$Timer.paused = true

func _on_timeout():
	left_welding_time -= 1
	if left_welding_time <= 0:
		$Timer.stop()
		print("AssembleStation(%d)._on_timeout index" % index)
		emit_signal("assembling_finished", index)
	_update_progress_bar()

func _update_progress_bar():
	var percentage = left_welding_time / welding_time
	$StationProgressBar.update_progress(percentage)
	$StationProgressBar.visible = percentage > 0

func get_slot_index() -> int :
	return $Items.slot

func _on_item_exploded():
	$Items.set_slot(-1)
	held_item = -1
	$Timer.stop()
