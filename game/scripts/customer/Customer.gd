extends "res://scripts/character/Character.gd"

var customer_data: CustomerData = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal costumer_leaves(customer_data)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# warning-ignore:unused_argument
func _process(delta):
	if customer_data == null:
		return
	if customer_data.task.taskFailed or customer_data.task.taskCompleted:
		emit_signal("costumer_leaves", customer_data)
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var direction : Vector2
	#direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	# TODO: set direction based on path
	
	if abs(direction.x) == 1 && abs(direction.y) == 1:
		direction = direction.normalized()
	
	var movement = speed * direction * delta
	
	# warning-ignore:return_value_discarded
	move_and_collide(movement)
	
	#if !attack_playing:
	animate_player(direction)

func animate_player(direction: Vector2):
	if direction != Vector2.ZERO:
		last_direction = 0.5 * (last_direction + direction)
		
		var animation = "walk_" + get_animation_direction(last_direction)
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
