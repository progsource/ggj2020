extends Panel

var requirements: Array = []
var pos: Array = [
	Vector2(4, 7),
	Vector2(12, 7),
	Vector2(20, 7),
	Vector2(28, 7),
]

onready var tools = preload("res://packed/items/Items.tscn")

func start():
	if requirements.size() == 0:
		return
	
	for i in range(requirements.size()):
		var item = tools.instance()
		add_child(item)
		item.display(requirements[i].requirement_index)
		item.scale.x = 0.5
		item.scale.y = 0.5
		item.position = pos[i]
		item.modulate = Color(1, 1, 1, 0.5)

# warning-ignore:unused_argument
func _process(delta):
	if requirements.size() == 0:
		return
	for i in range(requirements.size()):
		if requirements[i].requirement_satisfied:
			# warning-ignore:return_value_discarded
			get_child(i).modulate = Color(0, 1, 1, 1)
