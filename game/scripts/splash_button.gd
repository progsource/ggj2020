extends Button

func _ready():
	pass # Replace with function body.

func _input(event):
	# button_index 0 = XBox - A
	# button_index 1 = XBox - B
	# button_index 2 = XBox - Y
	# button_index 3 = XBox - X
	if event is InputEventJoypadButton and event.button_index == 0:
		_pressed()

func _pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Level.tscn")
