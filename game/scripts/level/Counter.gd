extends KinematicBody2D

signal device_returned(slot_index, device_index, original_slot_index)

export var has_vertical_sprite : bool = false
export var has_mirrored_sprite : bool = false
export var slot_index : int = -1
var vertical_sprite = preload("res://assets/img/progsource/counter_vertical.png")

func _ready():
	if has_vertical_sprite:
		$Sprite.texture = vertical_sprite
	$Sprite.flip_h = has_mirrored_sprite


func hold_item(var index : int, var original_slot_index : int):
	$Items.display(index)
	$Items.slot = original_slot_index
	emit_signal("device_returned", slot_index, index, original_slot_index)

func remove_item():
	$Items.hide_items()

func explode_item():
	$Items.explode()
