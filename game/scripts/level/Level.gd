extends Node2D

signal new_task_added(task)
signal item_picked_up(slot_index)
signal player_started_welding
signal player_stopped_welding
signal player_started_assembling(assemble_station_index)
signal player_stopped_assembling
signal player_started_washing(station_id)

var spawn_customer_packed = preload("res://packed/character/Customer.tscn")
var level_data := LevelData.new()
onready var devices_packed = preload("res://packed/items/Items.tscn")
var player_is_welding : bool = false
var player_is_assembling : bool = false setget set_player_is_assembling
var counter_stations = []
var assemble_stations = []

func set_player_is_assembling(var is_assembling : bool) -> void :
	print("Level.set_player_is_assembling: %s" % is_assembling)
	player_is_assembling = is_assembling

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

	counter_stations.push_back($Room0/Counter)
	counter_stations.push_back($Room0/Counter3)
	counter_stations.push_back($Room0/Counter5)
	counter_stations.push_back($Room0/Counter7)
	counter_stations.push_back($Room0/Counter9)

	for i in range(counter_stations.size()):
		connect("item_picked_up", counter_stations[i], "_on_item_picked_up")
		counter_stations[i].connect("device_returned", self, "_on_device_returned")

	assemble_stations.push_back($Room0/AssembleStation)
	assemble_stations.push_back($Room0/AssembleStation2)
	assemble_stations.push_back($Room0/AssembleStation3)

	for i in range(assemble_stations.size()):
		assemble_stations[i].index = i
		connect("player_started_assembling", assemble_stations[i], "_on_player_started_assembling")
		connect("player_stopped_assembling", assemble_stations[i], "_on_player_stopped_assembling")
		assemble_stations[i].connect("assembling_finished", self, "_on_assembling_finished")

	$Room0/WashMachine.index = 5
	connect("player_started_washing", $Room0/WashMachine, "_on_player_started_washing")
	$Room0/WashMachine.connect("washing_finished", self, "_on_washing_finished")

	$Room0/WeldingStation.connect("welding_finished", self, "_on_welding_finished")
	bind_player_to_leave()

# warning-ignore:unused_argument
func _process(delta):
	if !level_data.isRunning:
		return

	if Input.is_action_just_released("ui_accept"):
		$Player/Inputs.hide_inputs()
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
				$Room0/WeldingStation.hold_item($Player.held_item, $Player.get_slot_index())
				$Player.drop_item()
				$ItemMove.play()
			elif $Player.held_item == -1 && $Room0/WeldingStation.held_item != -1:
				$Player.hold_item($Room0/WeldingStation.held_item, $Room0/WeldingStation.get_slot_index())
				$Room0/WeldingStation.remove_item()
				$ItemMove.play()
		elif $Room0/WashMachine/Area2D.overlaps_body($Player):
			try_washing_machine($Room0/WashMachine)
	elif Input.is_action_just_pressed("take_action"):
		$Player/Inputs.hide_inputs()
		if $Room0/WeldingStation/Area2D.overlaps_body($Player):
			if $Player.held_item != -1 && $Room0/WeldingStation.held_item == -1:
				$Room0/WeldingStation.hold_item($Player.held_item, $Player.get_slot_index())
				$Player.drop_item()
				$ItemMove.play()
			$Room0/WeldingStation.start_welding()
			$Welding.play()
			player_is_welding = true
		if $Room0/AssembleStation/Area2D.overlaps_body($Player):
			try_start_to_assemble($Room0/AssembleStation)
		elif $Room0/AssembleStation2/Area2D.overlaps_body($Player):
			try_start_to_assemble($Room0/AssembleStation2)
		elif $Room0/AssembleStation3/Area2D.overlaps_body($Player):
			try_start_to_assemble($Room0/AssembleStation3)

	elif Input.is_action_just_released("take_action") && (player_is_welding || player_is_assembling):
		$Player/Inputs.hide_inputs()
		$Room0/WeldingStation.stop_welding()
		emit_signal("player_stopped_assembling")
		player_is_welding = false
		player_is_assembling = false
	else:
		check_for_input_hint()


func try_pickup_item(var counter : KinematicBody2D) :
	var counter_slot_index = counter.slot_index
	if $Player.held_item == -1 && level_data.customer_slots[counter_slot_index] && level_data.customer_slots[counter_slot_index].customer_data:
		var item_index = level_data.customer_slots[counter_slot_index].customer_data.task.device.sprite_index
		level_data.customer_slots[counter_slot_index].customer_data.task.taskStarted = true
		counter.remove_item()
		$Player.hold_item(item_index, counter_slot_index)
		emit_signal("item_picked_up", counter_slot_index)
		$ItemMove.play()
	elif $Player.held_item > -1 && counter.get_sprite_index() < 0 && $Player.held_item < 9 && level_data.customer_slots[counter_slot_index] && level_data.customer_slots[counter_slot_index].customer_data:
		counter.hold_item($Player.held_item, $Player.get_slot_index())
		$Player.drop_item()
		$ItemMove.play()

func try_washing_machine(var station : KinematicBody2D):
	if $Player.held_item == -1 && station.held_item != -1 && !station.washing:
		$Player.hold_item(station.held_item, station.get_slot_index())
		station.remove_item()
	elif station.held_item == -1 && $Player.held_item != -1:
		var slot_index = $Player.get_slot_index()
		var customer_slot = level_data.customer_slots[slot_index]
		var requirement = customer_slot.customer_data.task.get_current_requirement()
		if !requirement || requirement.requirement_index != Requirement.RequirementType.CLEANING:
			$Player.drop_item()
			station.explode_item()
			customer_slot.customer_data.task.taskFailed = true
		else:
			station.hold_item($Player.held_item, $Player.get_slot_index())
			$Player.drop_item()
			emit_signal("player_started_washing", station.index)
			$WashingMachine.play()

func try_assemble_station(var station : KinematicBody2D):
	if $Player.held_item == -1:
		if station.held_item != -1:
			$Player.hold_item(station.held_item, station.get_slot_index())
			station.remove_item()
			$ItemMove.play()
	elif $Player.held_item < 9: # player is holding device
		if station.held_item == -1:
			station.hold_item($Player.held_item, $Player.get_slot_index())
			$Player.drop_item()
			$ItemMove.play()

func try_start_to_assemble(var station : KinematicBody2D) -> void :
	print("#####try_start_to_assemble")
	print("station.held_item %d" % station.held_item)
	print("player held item %d" % $Player.held_item)
	if station.held_item != -1 && ($Player.held_item == 9 || $Player.held_item == 10):
		var slot_index = station.get_slot_index()
		print("station_slot_index %d" % slot_index)
		var customer_slot = level_data.customer_slots[slot_index]
		print("customer_slot_index %d" % customer_slot.index)
		var requirement = customer_slot.customer_data.task.get_current_requirement()
		print("requirement: %s" % requirement != null)
		if requirement:
			print("requirement_index %d" % requirement.requirement_index)
		if !requirement || requirement.requirement_index != $Player.held_item:
			$Player.drop_item()
			customer_slot.explode()
		else:
			emit_signal("player_started_assembling", station.index)
			$Assemble.play()
	print("#####try_start_to_assemble###############")

func _on_start_button_pressed():
	GlobalData.currently_in_use_devices.clear()
	start()

func start() -> void :
	level_data.start()
	$CustomerSpawnTimer.start()
	$BackgroundMusic.play()

func stop() -> void :
	level_data.stop()
	$CustomerSpawnTimer.stop()
	# warning-ignore:return_value_discarded
	GlobalData.score = level_data
	get_tree().change_scene("res://scenes/Highscore.tscn")

func _spawn_customer() -> void :
	$CustomerSpawnTimer.wait_time = 6
	var customer_slot = level_data.get_next_free_slot()
	customer_slot.customer_data = CustomerData.new()
	customer_slot.customer_data.slot = customer_slot.index
	customer_slot.customer_data.init_random_values()

	var customer = spawn_customer_packed.instance()
	customer.connect("costumer_leaves", self, "_despawn_customer")
	customer.customer_data = customer_slot.customer_data
	customer.position = customer_slot.position
	customer.get_node("Sprite").texture = customer_slot.customer_data.sprites[customer_slot.customer_data.sprite_index]
	add_child(customer)
	emit_signal("new_task_added", customer_slot.customer_data)

	counter_stations[customer_slot.index].hold_item(customer_slot.customer_data.task.device.sprite_index, customer_slot.index, false)
	$CustomerIncoming.play()

# warning-ignore:unused_argument
func _despawn_customer(customer_data: CustomerData):
	counter_stations[customer_data.slot].remove_item()
	level_data.free_slot(customer_data)
	$CustomerSpawnTimer.start()

func _on_customer_spawn_timer_timeout():
	if level_data.has_free_customer_slot():
		_spawn_customer()

func _on_assembling_finished(var station_index : int):
	print(station_index)
	$Player.drop_item()
	var slot_index = assemble_stations[station_index].get_slot_index()
	print("Level._on_assembling_finished slot_index: %d" % slot_index)

	var customer_slot = level_data.customer_slots[slot_index]
	var req = customer_slot.customer_data.task.get_current_requirement()
	req.requirement_satisfied = true

func _on_washing_finished(var station_index: int):
	var slot_index = $Room0/WashMachine.get_slot_index()
	var customer_slot = level_data.customer_slots[slot_index]
	var req = customer_slot.customer_data.task.get_current_requirement()
	req.requirement_satisfied = true

func _on_device_returned(var slot_index : int, var device_index : int, var original_slot_index : int):
	var customer_slot = level_data.customer_slots[slot_index]
	if original_slot_index != slot_index:
		customer_slot.customer_data.task.taskFailed = true
		counter_stations[slot_index].explode_item()
		var other_customer = level_data.customer_slots[original_slot_index]
		other_customer.customer_data.task.taskFailed = true
		other_customer.explode()
	elif customer_slot.customer_data.task.get_current_requirement() != null:
		customer_slot.customer_data.task.taskFailed = true
		counter_stations[slot_index].explode_item()
	else:
		customer_slot.customer_data.task.taskCompleted = true
		$TaskDoneSound.play()

func _on_welding_finished(var slot_index : int):
	print("welding finished %d" % slot_index)
	var customer_slot = level_data.customer_slots[slot_index]
	var requirement = customer_slot.customer_data.task.get_current_requirement()
	print("req indx %d" % requirement.requirement_index)
	if requirement.requirement_index != 11:
		customer_slot.explode()
		return

	requirement.requirement_satisfied = true

func check_for_input_hint():
	for node in $Room0.get_children():
		if node is KinematicBody2D:
			if "slot_index" in node && node.slot_index != -1:
				check_counter_for_input_hint(node)
			else:
				check_node_for_input_hint(node)

func check_node_for_input_hint(node: KinematicBody2D):
	if node.get_node("Area2D").overlaps_body($Player):
		if "welding_time" in node:
			if node.get_slot_index() != -1:
				if ($Player.held_item == 9 or $Player.held_item == 10):
					$Player/Inputs.display(1)
			elif $Player.held_item != -1:
				$Player/Inputs.display(0)
		if "washing_time" in node:
			if node.get_slot_index() == -1 && $Player.held_item != -1:
				$Player/Inputs.display(0)
			elif node.get_slot_index() != -1 && $Player.held_item == -1 && !node.washing:
				$Player/Inputs.display(0)
		if "SECONDS_TO_WELD" in node:
			if node.get_slot_index() == -1 && $Player.held_item != -1:
				$Player/Inputs.display(0)
			elif node.get_slot_index() != -1 && $Player.held_item == -1 && node.left_welding_time >= 1:
				$Player/Inputs.display(1)
			elif node.get_slot_index() != -1 && $Player.held_item == -1 && node.left_welding_time <= 0:
				$Player/Inputs.display(0)
		else:
			if $Player.held_item == -1:
				$Player/Inputs.display(0)

func check_counter_for_input_hint(node: KinematicBody2D):
	if node.get_node("Area2D").overlaps_body($Player):
		if $Player.held_item == -1:
			$Player/Inputs.display(0)

func bind_player_to_leave():
	for node in $Room0.get_children():
		if node is KinematicBody2D:
			if "slot_index" in node && node.slot_index != -1:
				node.get_node("Area2D").connect(
					"body_exited",
					$Player,
					"_on_body_exited"
				)
			else:
				node.get_node("Area2D").connect(
					"body_exited",
					$Player,
					"_on_body_exited"
				)
