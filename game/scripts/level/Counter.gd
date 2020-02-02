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

func _process(delta):
	pass

func hold_item(var device_index : int, var original_slot_index : int, var is_returned = true):
	$Items.display(device_index)
	$Items.set_slot(original_slot_index)
	if is_returned:
		emit_signal("device_returned", slot_index, device_index, original_slot_index)

func remove_item():
	$Items.hide_items()

func explode_item():
	$Items.explode()

func _on_item_picked_up(slot_index):
	$Items._on_item_picked_up(slot_index)

func get_sprite_index():
	if $Items.customer_data:
		return $Items.customer_data.task.device.sprite_index
	return -1
