extends Button

signal start_button_pressed

class_name StartButton

func _ready():
	# warning-ignore:return_value_discarded
	connect("pressed", self, "_on_StartButton_pressed")

func _input(event):
	# button_index 0 = XBox - A
	# button_index 1 = XBox - B
	# button_index 2 = XBox - Y
	# button_index 3 = XBox - X
	if event is InputEventJoypadButton and event.button_index == 0:
		_pressed()

func _on_StartButton_pressed():
	emit_signal("start_button_pressed")
	queue_free()
