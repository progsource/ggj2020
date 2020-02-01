extends Node2D

var full_size : float = 0


func _ready():
	full_size = $Progress.rect_size.x


func update_progress(var progress : float):
	var size : float = full_size * progress
	$Progress.rect_size.x = size


func reset():
	update_progress(0)
