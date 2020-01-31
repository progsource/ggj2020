extends KinematicBody2D

export var speed = 75
var direction : Vector2
var last_direction = Vector2(0, 1)
var other_animation_playing = false

func get_animation_direction(dir: Vector2) -> String: 
	var norm_direction = dir.normalized()
	
	if norm_direction.y >= 0.707:
		return "down"
	elif norm_direction.y <= -0.707:
		return "up"
	elif norm_direction.x <= -0.707:
		return "left"
	return "right"
