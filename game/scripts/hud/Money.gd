extends Node2D

var level : Node = null

func _ready():
	level = get_tree().root.get_node("Level")
	if level:
		# warning-ignore:return_value_discarded
		level.level_data.connect("money_updated", self, "_on_money_updated")


func _on_money_updated(var money : int):
	$Label.text = "%05d" % money
