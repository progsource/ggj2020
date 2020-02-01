extends Node2D

var spawn_customer_packed = preload("res://packed/character/Customer.tscn")
var level_data := LevelData.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start() -> void:
	level_data.start()

func spawn_customer() -> void:
	pass
	#var customer = spawn_customer_packed.instance()
