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
	sprite_index = rand_range(0, sprites.size())
	task = Task.new()
	task.device = Device.new()
	task.device.sprite_index = rand_range(0, 10) # TODO: do this based on available device types
	var requirements_count = rand_range(1, 4)
	for i in range(requirements_count):
		task.requirements.push_back(rand_range(0, 4))
	base_money = rand_range(2, 14)
	max_pickup_waiting_time_in_seconds = rand_range(20, 120)
	max_shipment_time_in_seconds = rand_range(40, 180)
