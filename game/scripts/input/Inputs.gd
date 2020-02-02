extends Node

enum InputType {
	CONFIRM,
	ACTION
}
var inputs = {}

func _ready():
	inputs[InputType.CONFIRM] = $Confirm
	inputs[InputType.ACTION] = $Action
	hide_inputs()

func hide_inputs() -> void :
	for i in range(0, inputs.size()):
		inputs[i].visible = false

func display(var input_type : int):
	if inputs[input_type].visible:
		return

	hide_inputs()
	print("Show Inputs %s" % input_type)
	inputs[input_type].visible = true
