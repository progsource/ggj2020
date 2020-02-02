extends Panel

var levelData: LevelData = null

func _ready():
	levelData = GlobalData.score

	$Money/Value.text = str(levelData.money)
	$Happiness/Value.text = str(levelData.customerHappiness)
	$Stars/Value.text = str(levelData.repairs)

func _on_Button_start_button_pressed():
	GlobalData.score = null
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Level.tscn")
