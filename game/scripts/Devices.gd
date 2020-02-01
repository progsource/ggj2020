extends Node2D

var devices = {}

enum DeviceType {Calculator, OldCamera, Controller, Headphones, Monitor, MusicPlayer, Notebook, OldMonitor, Phone}


func _ready():
	devices[DeviceType.Calculator] = $Calculator
	devices[DeviceType.OldCamera] = $Camera
	devices[DeviceType.Controller] = $Controller
	devices[DeviceType.Headphones] = $Headphones
	devices[DeviceType.Monitor] = $Monitor
	devices[DeviceType.MusicPlayer] = $MusicPlayer
	devices[DeviceType.Notebook] = $Notebook
	devices[DeviceType.OldMonitor] = $OldMonitor
	devices[DeviceType.Phone] = $Phone

	for i in range(0, devices.size()):
		devices[i].visible = false


func display(var device_type : int):
	devices[device_type].visible = true
	var current_height = devices[device_type].texture.get_height()
	var wanted_heigth : float = 20
	var scale = wanted_heigth / current_height
	devices[device_type].scale.x = scale
	devices[device_type].scale.y = scale

