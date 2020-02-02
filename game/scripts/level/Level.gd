extends Node2D

signal new_task_added(task)
signal item_picked_up(slot_index)
signal player_started_welding
signal player_stopped_welding
signal player_started_assembling(assemble_station_index)
signal player_stopped_assembling
signal player_started_washing(station_id)
signal player_stopped_washing

var spawn_customer_packed = preload("res://packed/character/Customer.tscn")
var level_data := LevelData.new()
onready var devices_packed = preload("res://packed/items/Items.tscn")
var player_is_welding : bool = false
var player_is_assembling : bool = false
var assemble_stations = []

func _ready():
	# warning-ignore:return_value_discarded
	connect("new_task_added", get_node("HUD/TaskList"), "_on_Task_recieved")
	# warning-ignore:return_value_discarded
	get_node("HUD/LevelTimer").connect("level_ended", self, "stop")
	# warning-ignore:return_value_discarded
	$CustomerSpawnTimer.connect("timeout", self, "_on_customer_spawn_timer_timeout")
	var start_button : StartButton = get_tree().root.get_node("Level/HUD/StartButton")
	if start_button:
		# warning-ignore:return_value_discarded
		start_button.connect("start_button_pressed", self, "_on_start_button_pressed")

	assemble_stations.push_back($Room0/AssembleStation)
	assemble_stations.push_back($Room0/AssembleStation2)
	assemble_stations.push_back($Room0/AssembleStation3)

	for i in range(assemble_stations.size()):
		assemble_stations[i].index = i
		connect("player_started_assembling", assemble_stations[i], "_on_player_started_assembling")
		connect("player_stopped_assembling", assemble_stations[i], "_on_player_stopped_assembling")
		assemble_stations[i].connect("assembling_finished", self, "_on_assembling_finished")

	$Room0/WashMachine.index = 1
	connect("player_started_washing", $Room0/WashMachine, "_on_player_started_washing")
	connect("player_stopped_washing", $Room0/WashMachine, "_on_player_started_washing")


# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		if $Room0/ScrewCrate/Area2D.overlaps_body($Player):
			if $Player.held_item == -1:
				$Player.hold_item(9, -1)
			elif $Player.held_item == 9:
				$Player.drop_item()
				#$Player.explode_item()
		elif $Room0/DisplayCrate/Area2D.overlaps_body($Player):
			if $Player.held_item == -1:
				$Player.hold_item(10, -1)
			elif $Player.held_item == 10:
				$Player.drop_item()

		if $Room0/Counter/Area2D.overlaps_body($Player):
			try_pickup_item($Room0/Counter)
		elif $Room0/Counter3/Area2D.overlaps_body($Player):
			try_pickup_item($Room0/Counter3)
		elif $Room0/Counter5/Area2D.overlaps_body($Player):
			try_pickup_item($Room0/Counter5)
		elif $Room0/Counter7/Area2D.overlaps_body($Player):
			try_pickup_item($Room0/Counter7)
		elif $Room0/Counter9/Area2D.overlaps_body($Player):
			try_pickup_item($Room0/Counter9)
		elif $Room0/AssembleStation/Area2D.overlaps_body($Player):
			try_assemble_station($Room0/AssembleStation)
		elif $Room0/AssembleStation2/Area2D.overlaps_body($Player):
			try_assemble_station($Room0/AssembleStation2)
		elif $Room0/AssembleStation3/Area2D.overlaps_body($Player):
			try_assemble_station($Room0/AssembleStation3)
		elif $Room0/WeldingStation/Area2D.overlaps_body($Player):
			if $Player.held_item != -1 && $Room0/WeldingStation.held_item == -1:
				$Room0/WeldingStation.hold_item($Player.held_item)
				$Player.drop_item()
			elif $Player.held_item == -1 && $Room0/WeldingStation.held_item != -1:
				$Player.hold_item($Room0/WeldingStation.held_item, $Room0/WeldingStation.get_slot_index())
				$Room0/WeldingStation.remove_item()
		elif $Room0/WashMachine/Area2D.overlaps_body($Player):
			emit_signal("player_started_washing", 1)
	elif Input.is_action_just_pressed("take_action"):
		if $Room0/WeldingStation/Area2D.overlaps_body($Player):
			if $Player.held_item != -1 && $Room0/WeldingStation.held_item == -1:
				$Room0/WeldingStation.hold_item($Player.held_item, $Player.get_slot_index())
				$Player.drop_item()

			emit_signal("player_started_welding")
			player_is_welding = true
			pass # here the progress has to start and tick as long as it is pressed
		if $Room0/AssembleStation/Area2D.overlaps_body($Player):
			try_start_to_assemble($Room0/AssembleStation)
		elif $Room0/AssembleStation2/Area2D.overlaps_body($Player):
			try_start_to_assemble($Room0/AssembleStation2)
		elif $Room0/AssembleStation3/Area2D.overlaps_body($Player):
			try_start_to_assemble($Room0/AssembleStation3)

	elif Input.is_action_just_released("take_action") && player_is_welding:
		emit_signal("player_stopped_welding")
		emit_signal("player_stopped_assembling")
		player_is_welding = false
		player_is_assembling = false
		pass # stop timer - hint on explosion this has to be set also to false


func try_pickup_item(var counter : KinematicBody2D) :
	var index = counter.slot_index
	if $Player.held_item == -1 && level_data.customer_slots[index] && level_data.customer_slots[index].customer_data:
		var item_index = level_data.customer_slots[index].customer_data.task.device.sprite_index
		level_data.customer_slots[index].customer_data.task.taskStarted = true
		$Player.hold_item(item_index, index)
		emit_signal("item_picked_up", index)
	elif $Player.held_item > -1 && $Player.held_item < 9 && level_data.customer_slots[index] && level_data.customer_slots[index].customer_data:
		counter.hold_item($Player.held_item)
		$Player.drop_item()


func try_assemble_station(var station : KinematicBody2D):
	if $Player.held_item == -1:
		if station.held_item != -1:
			$Player.hold_item(station.held_item, station.index)
			station.remove_item()
	elif $Player.held_item < 9: # player is holding device
		if station.held_item == -1:
			station.hold_item($Player.held_item, station.index)
			$Player.drop_item()

func try_start_to_assemble(var station : KinematicBody2D) -> void :
	if station.held_item != -1 && ($Player.held_item == 9 || $Player.held_item == 10):
		var slot_index = station.get_slot_index()
		var customer_slot = level_data.customer_slots[slot_index]
		var requirement = customer_slot.customer_data.task.get_current_requirement()
		if !requirement || requirement.requirement_index != $Player.held_item:
			$Player.drop_item()
			station.explode_item()
			customer_slot.customer_data.task.taskFailed = true
		else:
			emit_signal("player_started_assembling", station.index)

func _on_start_button_pressed():
	GlobalData.currently_in_use_devices.clear()
	start()

func start() -> void :
	level_data.start()
	$CustomerSpawnTimer.start()

func stop() -> void :
	level_data.stop()
	$CustomerSpawnTimer.stop()
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/splash.tscn")

func _spawn_customer() -> void :
	var customer_slot = level_data.get_next_free_slot()
	customer_slot.customer_data = CustomerData.new()
	customer_slot.customer_data.init_random_values()

	var customer = spawn_customer_packed.instance()
	customer.connect("costumer_leaves", self, "_despawn_customer")
	customer.customer_data = customer_slot.customer_data
	customer.position = customer_slot.position
	customer.get_node("Sprite").texture = customer_slot.customer_data.sprites[customer_slot.customer_data.sprite_index]
	add_child(customer)
	emit_signal("new_task_added", customer_slot.customer_data)

	var device = devices_packed.instance()
	device.slot = customer_slot.index
	device.customer_data = customer_slot.customer_data
	device.position = customer_slot.pickup_position
	connect("item_picked_up", device, "_on_item_picked_up")
	add_child(device)
	device.display(customer_slot.customer_data.task.device.sprite_index)

# warning-ignore:unused_argument
func _despawn_customer(customer_data: CustomerData):
	level_data.free_slot(customer_data)

func _on_customer_spawn_timer_timeout():
	if level_data.has_free_customer_slot():
		_spawn_customer()

func _on_assembling_finished(var station_index : int):
	print(station_index)
	$Player.drop_item()
	var slot_index = assemble_stations[station_index].get_slot_index()

	var customer_slot = level_data.customer_slots[slot_index]
	customer_slot.customer_data.task.requirements[0].requirement_satisfied = true
