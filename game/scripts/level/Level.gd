extends Node2D

signal new_task_added(task)

var spawn_customer_packed = preload("res://packed/character/Customer.tscn")
var level_data := LevelData.new()
onready var devices_packed = preload("res://packed/items/Items.tscn")


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

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		if $Room0/ScrewCrate/Area2D.overlaps_body($Player):
			if $Player.held_item == -1:
				$Player.hold_item(9)
			elif $Player.held_item == 9:
				$Player.drop_item()
		elif $Room0/DisplayCrate/Area2D.overlaps_body($Player):
			if $Player.held_item == -1:
				$Player.hold_item(10)
			elif $Player.held_item == 10:
				$Player.drop_item()


func _on_start_button_pressed():
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
	customer.position = customer_slot.position
	customer.get_node("Sprite").texture = customer_slot.customer_data.sprites[customer_slot.customer_data.sprite_index]
	add_child(customer)
	emit_signal("new_task_added", customer_slot.customer_data.task)

	var device = devices_packed.instance()
	device.position = customer_slot.pickup_position
	add_child(device)
	device.display(customer_slot.customer_data.task.device.sprite_index)

func _on_customer_spawn_timer_timeout():
	if level_data.has_free_customer_slot():
		_spawn_customer()
