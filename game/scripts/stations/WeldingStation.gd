extends KinematicBody2D

var held_item : int = -1

func hold_item(var index : int):
	$Items.display(index)
	held_item = index

func remove_item():
	held_item = -1
	$Items.hide_items()
