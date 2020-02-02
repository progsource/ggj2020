extends KinematicBody2D

var held_item : int = -1

func hold_item(var index : int, var slot_index : int):
	$Items.display(index)
	$Items.slot = slot_index
	held_item = index

func remove_item():
	held_item = -1
	$Items.hide_items()
	$Items.slot = -1

func get_slot_index() -> int :
	return $Items.slot
