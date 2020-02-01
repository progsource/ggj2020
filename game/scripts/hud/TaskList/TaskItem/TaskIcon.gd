extends Node

export var type: String = "Mobile"

onready var mobile = preload("res://packed/items/Mobile.tscn")

func _ready():
	var icon
	match type:
		"Mobile":
			icon = mobile.instance()

	add_child(icon)
