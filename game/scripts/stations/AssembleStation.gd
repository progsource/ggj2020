extends KinematicBody2D

var held_item : int = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func hold_item(var index : int):
	print("%d should be shown" % index)
	$Items.display(index)
	held_item = index

func remove_item():
	held_item = -1
	$Items.hide_items()
