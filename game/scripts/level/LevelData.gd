extends Reference

class_name LevelData

var isRunning : bool = false
var money : int = 0
var happiness : int = 0
var customer_slots := {}

# TODO set positions to correct places on screen
const customer_slot_positions = [
	Vector2(0, 0),
	Vector2(0, 1),
	Vector2(0, 2),
	Vector2(0, 3),
	Vector2(0, 4),
]

# TODO set positions to correct places on screen
# note left bottom + size of 32x32
const pickup_slot_positions = [
	Vector2(0, 0),
	Vector2(0, 1),
	Vector2(0, 2),
	Vector2(0, 3),
	Vector2(0, 4),
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
