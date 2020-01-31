extends "res://scripts/character/Character.gd"

var can_move : bool = false

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
	
	#if attack_playing:
	#	movement *= 0.3
	
	# warning-ignore:return_value_discarded
	move_and_collide(movement)
	
	#if !attack_playing:
		#animate_player(direction)
		
	#if direction != Vector2.ZERO:
	#	$RayCast2D.cast_to = direction.normalized() * 8

func _on_start_button_pressed():
	can_move = true

#func animate_player(direction: Vector2):
#	pass
	#if direction != Vector2.ZERO:
	#	last_direction = 0.5 * (last_direction + direction)
		
	#	var animation = get_animation_direction(last_direction) + "_walk"
		
	#	$Sprite.frames.set_animation_speed(animation, 2 + 8 * direction.length())
	#	$Sprite.play(animation)
	#else:
	#	var animation = get_animation_direction(last_direction) + "_idle"
	#	$Sprite.play(animation)

