extends Reference

signal money_updated
signal happiness_updated

class_name LevelData

var isRunning : bool = false
var money : int = 0
var happiness : int = 0
var customer_slots := {}

# TODO set positions to correct places on screen
const customer_slot_positions = [
	Vector2(320, 48),
	Vector2(320, 80),
	Vector2(240, 80),
	Vector2(176, 80),
	Vector2(176, 48),
]

# TODO set positions to correct places on screen
# note left bottom + size of 32x32
const pickup_slot_positions = [
	Vector2(352, 48),
	Vector2(320, 112),
	Vector2(240, 112),
	Vector2(176, 112),
	Vector2(144, 48),
]

class CustomerSlot:
	var position := Vector2(0, 0)
	var pickup_position := Vector2(0, 0)
	var customer_data : CustomerData = null

func _setup_customer_slots() -> void:
	customer_slots.clear()
	for i in range(customer_slot_positions.size()):
		customer_slots[i] = CustomerSlot.new()
		customer_slots[i].position = customer_slot_positions[i]
		customer_slots[i].pickup_position = pickup_slot_positions[i]

func start() -> void:
	money = 0
	happiness = 100
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
	self.happiness += change
	emit_signal("happiness_updated", happiness)

func has_free_customer_slot() -> bool :
	return get_next_free_slot() != null

func get_next_free_slot() -> CustomerSlot :
	for i in range(customer_slots.size()):
		if !customer_slots[i].customer_data:
			return customer_slots[i]
	return null
