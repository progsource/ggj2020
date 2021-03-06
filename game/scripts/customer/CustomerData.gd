extends Reference

class_name CustomerData

const sprites = [
	preload("res://assets/img/pipoya/Male/Male 01-1.png"),
	preload("res://assets/img/pipoya/Male/Male 01-2.png"),
	preload("res://assets/img/pipoya/Male/Male 01-3.png"),
	preload("res://assets/img/pipoya/Male/Male 01-4.png"),
	preload("res://assets/img/pipoya/Male/Male 02-1.png"),
	preload("res://assets/img/pipoya/Male/Male 02-2.png"),
	preload("res://assets/img/pipoya/Male/Male 02-3.png"),
	preload("res://assets/img/pipoya/Male/Male 02-4.png"),
	preload("res://assets/img/pipoya/Male/Male 03-1.png"),
	preload("res://assets/img/pipoya/Male/Male 03-2.png"),
	preload("res://assets/img/pipoya/Male/Male 03-3.png"),
	preload("res://assets/img/pipoya/Male/Male 03-4.png"),
	preload("res://assets/img/pipoya/Male/Male 04-1.png"),
	preload("res://assets/img/pipoya/Male/Male 04-2.png"),
	preload("res://assets/img/pipoya/Male/Male 04-3.png"),
	preload("res://assets/img/pipoya/Male/Male 04-4.png"),
	preload("res://assets/img/pipoya/Male/Male 05-1.png"),
	preload("res://assets/img/pipoya/Male/Male 05-2.png"),
	preload("res://assets/img/pipoya/Male/Male 05-3.png"),
	preload("res://assets/img/pipoya/Male/Male 05-4.png"),
	preload("res://assets/img/pipoya/Male/Male 06-1.png"),
	preload("res://assets/img/pipoya/Male/Male 06-2.png"),
	preload("res://assets/img/pipoya/Male/Male 06-3.png"),
	preload("res://assets/img/pipoya/Male/Male 06-4.png"),
	preload("res://assets/img/pipoya/Male/Male 07-1.png"),
	preload("res://assets/img/pipoya/Male/Male 07-2.png"),
	preload("res://assets/img/pipoya/Male/Male 07-3.png"),
	preload("res://assets/img/pipoya/Male/Male 07-4.png"),
	preload("res://assets/img/pipoya/Male/Male 08-1.png"),
	preload("res://assets/img/pipoya/Male/Male 08-2.png"),
	preload("res://assets/img/pipoya/Male/Male 08-3.png"),
	preload("res://assets/img/pipoya/Male/Male 08-4.png"),
	preload("res://assets/img/pipoya/Male/Male 09-1.png"),
	preload("res://assets/img/pipoya/Male/Male 09-2.png"),
	preload("res://assets/img/pipoya/Male/Male 09-3.png"),
	preload("res://assets/img/pipoya/Male/Male 09-4.png"),
	preload("res://assets/img/pipoya/Male/Male 10-1.png"),
	preload("res://assets/img/pipoya/Male/Male 10-2.png"),
	preload("res://assets/img/pipoya/Male/Male 10-3.png"),
	preload("res://assets/img/pipoya/Male/Male 10-4.png"),
	preload("res://assets/img/pipoya/Male/Male 11-1.png"),
	preload("res://assets/img/pipoya/Male/Male 11-2.png"),
	preload("res://assets/img/pipoya/Male/Male 11-3.png"),
	preload("res://assets/img/pipoya/Male/Male 11-4.png"),
	preload("res://assets/img/pipoya/Male/Male 12-1.png"),
	preload("res://assets/img/pipoya/Male/Male 12-2.png"),
	preload("res://assets/img/pipoya/Male/Male 12-3.png"),
	preload("res://assets/img/pipoya/Male/Male 12-4.png"),
	preload("res://assets/img/pipoya/Male/Male 13-1.png"),
	preload("res://assets/img/pipoya/Male/Male 13-2.png"),
	preload("res://assets/img/pipoya/Male/Male 13-3.png"),
	preload("res://assets/img/pipoya/Male/Male 13-4.png"),
	preload("res://assets/img/pipoya/Male/Male 14-1.png"),
	preload("res://assets/img/pipoya/Male/Male 14-2.png"),
	preload("res://assets/img/pipoya/Male/Male 14-3.png"),
	preload("res://assets/img/pipoya/Male/Male 14-4.png"),
	preload("res://assets/img/pipoya/Male/Male 15-1.png"),
	preload("res://assets/img/pipoya/Male/Male 15-2.png"),
	preload("res://assets/img/pipoya/Male/Male 15-3.png"),
	preload("res://assets/img/pipoya/Male/Male 15-4.png"),
	preload("res://assets/img/pipoya/Male/Male 16-1.png"),
	preload("res://assets/img/pipoya/Male/Male 16-2.png"),
	preload("res://assets/img/pipoya/Male/Male 16-3.png"),
	preload("res://assets/img/pipoya/Male/Male 16-4.png"),
	preload("res://assets/img/pipoya/Male/Male 17-1.png"),
	preload("res://assets/img/pipoya/Male/Male 17-2.png"),
	preload("res://assets/img/pipoya/Male/Male 17-3.png"),
	preload("res://assets/img/pipoya/Male/Male 17-4.png"),
	preload("res://assets/img/pipoya/Male/Male 18-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 01-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 02-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 03-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 04-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 05-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 06-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 07-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 08-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 09-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 10-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 11-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 12-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 13-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 14-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 15-1.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 15-2.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 15-3.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 15-4.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 15-5.png"),
	preload("res://assets/img/pipoya/Enemy/Enemy 15-6.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 01-1.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 01-2.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 01-3.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 01-4.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 02-1.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 02-2.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 02-3.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 02-4.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 03-1.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 03-2.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 03-3.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 03-4.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 04-1.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 04-2.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 04-3.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 04-4.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 05-1.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 05-2.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 05-3.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 05-4.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 06-1.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 06-2.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 06-3.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 06-4.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 07-1.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 07-2.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 07-3.png"),
	preload("res://assets/img/pipoya/Soldier/Soldier 07-4.png"),
	preload("res://assets/img/pipoya/Female/Female 01-1.png"),
	preload("res://assets/img/pipoya/Female/Female 01-2.png"),
	preload("res://assets/img/pipoya/Female/Female 01-3.png"),
	preload("res://assets/img/pipoya/Female/Female 01-4.png"),
	preload("res://assets/img/pipoya/Female/Female 02-1.png"),
	preload("res://assets/img/pipoya/Female/Female 02-2.png"),
	preload("res://assets/img/pipoya/Female/Female 02-3.png"),
	preload("res://assets/img/pipoya/Female/Female 02-4.png"),
	preload("res://assets/img/pipoya/Female/Female 03-1.png"),
	preload("res://assets/img/pipoya/Female/Female 03-2.png"),
	preload("res://assets/img/pipoya/Female/Female 03-3.png"),
	preload("res://assets/img/pipoya/Female/Female 03-4.png"),
	preload("res://assets/img/pipoya/Female/Female 04-1.png"),
	preload("res://assets/img/pipoya/Female/Female 04-2.png"),
	preload("res://assets/img/pipoya/Female/Female 04-3.png"),
	preload("res://assets/img/pipoya/Female/Female 04-4.png"),
	preload("res://assets/img/pipoya/Female/Female 05-1.png"),
	preload("res://assets/img/pipoya/Female/Female 05-2.png"),
	preload("res://assets/img/pipoya/Female/Female 05-3.png"),
	preload("res://assets/img/pipoya/Female/Female 05-4.png"),
	preload("res://assets/img/pipoya/Female/Female 06-1.png"),
	preload("res://assets/img/pipoya/Female/Female 06-2.png"),
	preload("res://assets/img/pipoya/Female/Female 06-3.png"),
	preload("res://assets/img/pipoya/Female/Female 06-4.png"),
	preload("res://assets/img/pipoya/Female/Female 07-1.png"),
	preload("res://assets/img/pipoya/Female/Female 07-2.png"),
	preload("res://assets/img/pipoya/Female/Female 07-3.png"),
	preload("res://assets/img/pipoya/Female/Female 07-4.png"),
	preload("res://assets/img/pipoya/Female/Female 08-1.png"),
	preload("res://assets/img/pipoya/Female/Female 08-2.png"),
	preload("res://assets/img/pipoya/Female/Female 08-3.png"),
	preload("res://assets/img/pipoya/Female/Female 08-4.png"),
	preload("res://assets/img/pipoya/Female/Female 09-1.png"),
	preload("res://assets/img/pipoya/Female/Female 09-2.png"),
	preload("res://assets/img/pipoya/Female/Female 09-3.png"),
	preload("res://assets/img/pipoya/Female/Female 09-4.png"),
	preload("res://assets/img/pipoya/Female/Female 10-1.png"),
	preload("res://assets/img/pipoya/Female/Female 10-2.png"),
	preload("res://assets/img/pipoya/Female/Female 10-3.png"),
	preload("res://assets/img/pipoya/Female/Female 10-4.png"),
	preload("res://assets/img/pipoya/Female/Female 11-1.png"),
	preload("res://assets/img/pipoya/Female/Female 11-2.png"),
	preload("res://assets/img/pipoya/Female/Female 11-3.png"),
	preload("res://assets/img/pipoya/Female/Female 11-4.png"),
	preload("res://assets/img/pipoya/Female/Female 12-1.png"),
	preload("res://assets/img/pipoya/Female/Female 12-2.png"),
	preload("res://assets/img/pipoya/Female/Female 12-3.png"),
	# Female 12-4 is the player
	preload("res://assets/img/pipoya/Female/Female 13-1.png"),
	preload("res://assets/img/pipoya/Female/Female 13-2.png"),
	preload("res://assets/img/pipoya/Female/Female 13-3.png"),
	preload("res://assets/img/pipoya/Female/Female 13-4.png"),
	preload("res://assets/img/pipoya/Female/Female 14-1.png"),
	preload("res://assets/img/pipoya/Female/Female 14-2.png"),
	preload("res://assets/img/pipoya/Female/Female 14-3.png"),
	preload("res://assets/img/pipoya/Female/Female 14-4.png"),
	preload("res://assets/img/pipoya/Female/Female 15-1.png"),
	preload("res://assets/img/pipoya/Female/Female 15-2.png"),
	preload("res://assets/img/pipoya/Female/Female 15-3.png"),
	preload("res://assets/img/pipoya/Female/Female 15-4.png"),
	preload("res://assets/img/pipoya/Female/Female 16-1.png"),
	preload("res://assets/img/pipoya/Female/Female 16-2.png"),
	preload("res://assets/img/pipoya/Female/Female 16-3.png"),
	preload("res://assets/img/pipoya/Female/Female 16-4.png"),
	preload("res://assets/img/pipoya/Female/Female 17-1.png"),
	preload("res://assets/img/pipoya/Female/Female 17-2.png"),
	preload("res://assets/img/pipoya/Female/Female 17-3.png"),
	preload("res://assets/img/pipoya/Female/Female 17-4.png"),
	preload("res://assets/img/pipoya/Female/Female 18-1.png"),
	preload("res://assets/img/pipoya/Female/Female 18-2.png"),
	preload("res://assets/img/pipoya/Female/Female 18-3.png"),
	preload("res://assets/img/pipoya/Female/Female 18-4.png"),
	preload("res://assets/img/pipoya/Female/Female 19-1.png"),
	preload("res://assets/img/pipoya/Female/Female 19-2.png"),
	preload("res://assets/img/pipoya/Female/Female 19-3.png"),
	preload("res://assets/img/pipoya/Female/Female 19-4.png"),
	preload("res://assets/img/pipoya/Female/Female 20-1.png"),
	preload("res://assets/img/pipoya/Female/Female 20-2.png"),
	preload("res://assets/img/pipoya/Female/Female 20-3.png"),
	preload("res://assets/img/pipoya/Female/Female 20-4.png"),
	preload("res://assets/img/pipoya/Female/Female 21-1.png"),
	preload("res://assets/img/pipoya/Female/Female 21-2.png"),
	preload("res://assets/img/pipoya/Female/Female 21-3.png"),
	preload("res://assets/img/pipoya/Female/Female 21-4.png"),
	preload("res://assets/img/pipoya/Female/Female 22-1.png"),
	preload("res://assets/img/pipoya/Female/Female 22-2.png"),
	preload("res://assets/img/pipoya/Female/Female 22-3.png"),
	preload("res://assets/img/pipoya/Female/Female 22-4.png"),
	preload("res://assets/img/pipoya/Female/Female 23-1.png"),
	preload("res://assets/img/pipoya/Female/Female 24-1.png"),
	preload("res://assets/img/pipoya/Female/Female 25-1.png"),
]

var rng = RandomNumberGenerator.new()

var sprite_index : int = 0
var task : Task = null
var base_money : int = 0
var max_pickup_waiting_time_in_seconds : int = 0
var max_shipment_time_in_seconds : int = 0
var slot : int = -1

func init_random_values() -> void:
	rng.seed = OS.get_ticks_msec()
	rng.randomize()

	sprite_index = rng.randi_range(0, sprites.size() - 1)
	print("task sprite_index: %d" % sprite_index)
	task = Task.new()
	task.device = Device.new()
	task.device.sprite_index = _get_random_device()
	print("task device sprite_index %d" % task.device.sprite_index)
	var requirements_count = rng.randi_range(1, 4)
	for _i in range(requirements_count):
		var requirement = Requirement.new()
		requirement.requirement_index = rng.randi_range(9, 12)
		print("requirement index: %d" % requirement.requirement_index)
		task.requirements.push_back(requirement)
		
	for req in task.requirements:
		print("double check req index %d" % req.requirement_index)
	base_money = rng.randi_range(2, 14)
	var time = rng.randi_range(60, 180)
	task.waitingTime = time
	task.reward = base_money
	max_pickup_waiting_time_in_seconds = time
	max_shipment_time_in_seconds = rng.randi_range(80, 240)

func _get_random_device() -> int :
	var device_index = -1
	var max_tries = 9
	var tries = 0
	while device_index == -1 && tries < max_tries :
		tries += 1
		device_index = rng.randi_range(0, 8)
		if device_index in GlobalData.currently_in_use_devices:
			device_index = -1
	if device_index == -1:
		device_index = rng.randi_range(0, 9)
	GlobalData.currently_in_use_devices.push_back(device_index)
	return device_index
