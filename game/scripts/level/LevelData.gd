extends Reference

signal money_updated
signal happiness_updated

class_name LevelData

var isRunning : bool = false
var money : int = 0
var happiness : int = 0
var customer_slots := {}

const customer_slot_positions = [
	Vector2(304, 48),
	Vector2(304, 80),
	Vector2(240, 80),
	Vector2(176, 80),
	Vector2(176, 48),
]

# note left bottom + size of 32x32
const pickup_slot_positions = [
	Vector2(336, 42),
	Vector2(304, 106),
	Vector2(240, 106),
	Vector2(176, 106),
	Vector2(144, 42),
]

class CustomerSlot:
	signal exploded(index)
	var index : int = -1
	var position := Vector2(0, 0)
	var pickup_position := Vector2(0, 0)
	var customer_data : CustomerData = null
	func explode():
		emit_signal("exploded", index)
		if customer_data:
			GlobalData.currently_in_use_devices.erase(customer_data.task.device.sprite_index)
			customer_data.task.taskFailed = true

func _setup_customer_slots() -> void:
	customer_slots.clear()
	for i in range(customer_slot_positions.size()):
		customer_slots[i] = CustomerSlot.new()
		customer_slots[i].index = i
		customer_slots[i].position = customer_slot_positions[i]
		customer_slots[i].pickup_position = pickup_slot_positions[i]

func start() -> void:
	money = 0
	happiness = 100
	#customerHappiness = 0
	_setup_customer_slots()
	isRunning = true
	emit_signal("money_updated", money)
	emit_signal("happiness_updated", happiness)

func stop() -> void :
	isRunning = false

func add_money(var change : int):
	self.money += change
	emit_signal("money_updated", self.money)

func update_happiness(var change : int):
	change = max(0, min(change, 100))
	self.happiness += change
	emit_signal("happiness_updated", happiness)

func has_free_customer_slot() -> bool :
	return get_next_free_slot() != null

func get_next_free_slot() -> CustomerSlot :
	for i in range(customer_slots.size()):
		if !customer_slots[i].customer_data:
			return customer_slots[i]
	return null

func free_slot(customer_data: CustomerData):
	for i in range(customer_slots.size()):
		if customer_slots[i].customer_data == customer_data:
			handle_reward(customer_data)
			customer_slots[i] = CustomerSlot.new()
			customer_slots[i].index = i
			customer_slots[i].position = customer_slot_positions[i]
			customer_slots[i].pickup_position = pickup_slot_positions[i]
			return

func handle_reward(customer_data: CustomerData):
	# warning-ignore:integer_division
	var customer_happiness = customer_data.task.startedAt * 100 / customer_data.task.waitingTime
	if customer_data.task.taskFailed:
		return
	update_happiness(customer_happiness)
	add_money(customer_data.task.reward)
