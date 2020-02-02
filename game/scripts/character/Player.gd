extends "res://scripts/character/Character.gd"

var can_move : bool = false
var held_item : int = -1

func _ready():
	var start_button : StartButton = get_tree().root.get_node("Level/HUD/StartButton")
	if start_button:
		# warning-ignore:return_value_discarded
		start_button.connect("start_button_pressed", self, "_on_start_button_pressed")


func _physics_process(delta):
	if !can_move:
		return
	var direction : Vector2
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if abs(direction.x) == 1 && abs(direction.y) == 1:
		direction = direction.normalized()
	
	var movement = speed * direction * delta
	var collision_info = move_and_collide(movement)
	animate_player(direction)


func _on_start_button_pressed():
	can_move = true


func animate_player(direction: Vector2):
	if direction != Vector2.ZERO:
		last_direction = 0.5 * (last_direction + direction)
		
		var animation = "player_" + get_animation_direction(last_direction)
		$AnimationPlayer.play(animation)
	else:
		$AnimationPlayer.stop()
		var current_frame = $Sprite.frame
		if current_frame < 3:
			$Sprite.frame = 1
		elif current_frame < 6:
			$Sprite.frame = 4
		elif current_frame < 9:
			$Sprite.frame = 7
		else:
			$Sprite.frame = 10


func hold_item(var item_index : int, var slot_index : int):
	print("hold item %d" % item_index)
	assert($Items)
	$Items.display(item_index)
	$Items.slot = slot_index
	$ItemAnimation.play("item_hover")
	held_item = item_index

func drop_item():
	print("drop item")
	$Items.hide_items()
	$Items.slot = -1
	$ItemAnimation.stop()
	held_item = -1

func explode_item():
	print("explode")
	$Items.explode()
	$Items.slot = -1
	$ItemAnimation.stop()
	held_item = -1

func get_slot_index() -> int :
	return $Items.slot
