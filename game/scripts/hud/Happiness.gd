extends Node2D

var level : Node = null
const MAX_HAPPINESS : int = 100
var full_size : float = 0

func _ready():
	full_size = $Progress.rect_size.x
	level = get_tree().root.get_node("Level")
	if level:
		# warning-ignore:return_value_discarded
		level.level_data.connect("happiness_updated", self, "_on_happiness_updated")

func _on_happiness_updated(var happiness : int):
	var percentage : float = float(happiness) / float(MAX_HAPPINESS)
	var size : float = full_size * percentage
	$Progress.rect_size.x = size
