extends Node2D

signal item_exploded

var items = {}

enum ItemType {
	Calculator, OldCamera, Controller, Headphones, Monitor, MusicPlayer, Notebook, OldMonitor, Phone,
	Screw, Displays,
	MetalTable, WashMachine
}

const DEVICE_AMOUNT : int = 9

func _ready():
	items[ItemType.Calculator] = $Calculator
	items[ItemType.OldCamera] = $Camera
	items[ItemType.Controller] = $Controller
	items[ItemType.Headphones] = $Headphones
	items[ItemType.Monitor] = $Monitor
	items[ItemType.MusicPlayer] = $MusicPlayer
	items[ItemType.Notebook] = $Notebook
	items[ItemType.OldMonitor] = $OldMonitor
	items[ItemType.Phone] = $Phone
	items[ItemType.Screw] = $Screw
	items[ItemType.Displays] = $Displays
	items[ItemType.MetalTable] = $MetalTable
	items[ItemType.WashMachine] = $WashMachine

	hide_items()

func _process(delta):
	if $Explosion.frame == 7:
		$Explosion.stop()
		hide_items()
		$Explosion.frame = 0

func display(var item_type : int):
	hide_items()
	items[item_type].visible = true
	
	if item_type < DEVICE_AMOUNT:
		var current_height = items[item_type].texture.get_height()
		var wanted_heigth : float = 16
		var scale = wanted_heigth / current_height
		items[item_type].scale.x = scale
		items[item_type].scale.y = scale

func hide_items() -> void :
	for i in range(0, items.size()):
		items[i].visible = false

func explode() -> void :
	$Explosion.play("default")
	
