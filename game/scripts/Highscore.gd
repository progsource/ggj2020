extends Panel

var levelData: LevelData = null

func _ready():
	levelData = GlobalData.score

	$Money/Value.text = str(levelData.money)
	$Happiness/Value.text = str(levelData.customerHappiness)

func _on_Button_pressed():
	GlobalData.score = null
	get_tree().change_scene("res://scenes/Level.tscn")
