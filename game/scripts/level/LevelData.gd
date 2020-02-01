extends Reference

var isRunning : bool = false
var money : int = 0
var happiness : int = 0
var customer_slots := {}

const customer_slot_positions = [
	Vector2(0, 0),
	Vector2(0, 1),
	Vector2(0, 2),
	Vector2(0, 3),
	Vector2(0, 4),
]

class CustomerSlot:
	var position := Vector2(0, 0)
	var customer : CustomerData = null

func _setup_customer_slots() -> void:
	customer_slots.clear()
	for i in range(customer_slot_positions.size()):
		customer_slots[i] = CustomerSlot.new()
		customer_slots[i].position = customer_slot_positions[i]

func start() -> void:
	money = 0
	happiness = 100
	_setup_customer_slots()
	isRunning = true
