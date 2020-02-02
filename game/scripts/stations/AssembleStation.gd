extends KinematicBody2D

signal assembling_finished
var held_item : int = -1
const welding_time = 4.0
var left_welding_time = 0.0
var index = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.connect("timeout", self, "_on_timeout")
	_update_progress_bar()

func hold_item(var index : int, var slot_index : int):
	print("%d should be shown" % index)
	$Items.display(index)
	$Items.slot = slot_index
	held_item = index

func explode_item():
	$Items.explode()
	$Items.slot = -1
	held_item = -1
	$Timer.stop()

func remove_item():
	held_item = -1
	$Items.hide_items()
	$Items.slot = -1

func _on_player_started_assembling(var station_index):
	if station_index != index:
		return
	print("start assemble %d" % station_index)
	left_welding_time = welding_time
	$Timer.start()

func _on_player_stopped_assembling(var station_index):
	$Timer.paused = true

func _on_timeout():
	left_welding_time -= 1
	if left_welding_time <= 0:
		$Timer.stop()
		emit_signal("assembling_finished", index)
	_update_progress_bar()

func _update_progress_bar():
	var percentage = left_welding_time / welding_time
	$StationProgressBar.update_progress(percentage)
	$StationProgressBar.visible = percentage > 0

func get_slot_index() -> int :
	return $Items.slot
