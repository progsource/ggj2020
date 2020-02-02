extends KinematicBody2D

signal device_returned(device_index)

export var has_vertical_sprite : bool = false
export var has_mirrored_sprite : bool = false
export var slot_index : int = -1
var vertical_sprite = preload("res://assets/img/progsource/counter_vertical.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	if has_vertical_sprite:
		$Sprite.texture = vertical_sprite

	$Sprite.flip_h = has_mirrored_sprite


func hold_item(var index : int):
	$Items.display(index)
	emit_signal("device_returned", index)

func remove_item():
	$Items.hide_items()

func explode_item():
	$Items.explode()
