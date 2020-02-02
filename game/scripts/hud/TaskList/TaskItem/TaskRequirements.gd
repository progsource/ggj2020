extends Panel

var requirements: Array = []
var pos: Array = [
	Vector2(4, 7),
	Vector2(12, 7),
	Vector2(20, 7),
	Vector2(28, 7),
]

var checkmarks: Array = [
	Node2D.new(),
	Node2D.new(),
	Node2D.new(),
	Node2D.new(),
]

onready var tools = preload("res://packed/items/Items.tscn")
onready var check = preload("res://assets/img/progsource/checkmark.png")

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
	for i in range(checkmarks.size()):
		checkmarks[i].visible = false
		add_child(checkmarks[i])
		var checkmark = TextureRect.new()
		checkmark.texture = check
		checkmarks[i].add_child(checkmark)
		checkmarks[i].scale.x = 0.5
		checkmarks[i].scale.y = 0.5
		checkmarks[i].position.x = pos[i].x - 4
		checkmarks[i].position.y = 1

# warning-ignore:unused_argument
func _process(delta):
	if requirements.size() == 0:
		return
	for i in range(requirements.size()):
		if requirements[i].requirement_satisfied && get_child(i).visible:
			# warning-ignore:return_value_discarded
			get_child(i).visible = false
			checkmarks[i].visible = true
