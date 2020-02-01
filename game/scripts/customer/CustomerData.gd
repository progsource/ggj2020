extends Reference

class_name CustomerData

const sprites = [
	"res://assets/img/pipoya/Male/Male 01-1.png",
	"res://assets/img/pipoya/Male/Male 01-2.png",
	"res://assets/img/pipoya/Male/Male 01-3.png",
	"res://assets/img/pipoya/Male/Male 01-4.png",
	"res://assets/img/pipoya/Male/Male 02-1.png",
	"res://assets/img/pipoya/Male/Male 02-2.png",
	"res://assets/img/pipoya/Male/Male 02-3.png",
	"res://assets/img/pipoya/Male/Male 03-4.png",
	# TODO: add more
]

var sprite_index : int = 0
var task : Task = null
var base_money : int = 0
var max_pickup_waiting_time_in_seconds : int = 0
var max_shipment_time_in_seconds : int = 0

func init_random_values() -> void:
	sprite_index = randi() % sprites.size()
	task = Task.new()
	task.device = Device.new()
	task.device.sprite_index = randi() % 10 # TODO: do this based on available device types
	var requirements_count = rand_range(1, 4)
	for _i in range(requirements_count):
		task.requirements.push_back(rand_range(0, 4))
	base_money = randi() % 14 + 2
	max_pickup_waiting_time_in_seconds = randi() % 120 + 20
	max_shipment_time_in_seconds = randi() % 180 + 40
