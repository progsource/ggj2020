extends KinematicBody2D

export var has_vertical_sprite : bool = false
export var has_mirrored_sprite : bool = false
var vertical_sprite = preload("res://assets/img/progsource/counter_vertical.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	if has_vertical_sprite:
		$Sprite.texture = vertical_sprite

	$Sprite.flip_h = has_mirrored_sprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
