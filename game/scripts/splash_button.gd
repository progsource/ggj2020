extends Button

func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_released("ui_accept"):
		_pressed()

func _pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Level.tscn")
