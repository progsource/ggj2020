extends Button

signal start_button_pressed

func _ready():
	connect("pressed", self, "_on_StartButton_pressed")

func _on_StartButton_pressed():
	emit_signal("start_button_pressed")
	queue_free()
