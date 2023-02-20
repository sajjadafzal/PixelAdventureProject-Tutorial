extends KinematicBody2D

export(float) var move_speed = 200

var velocity : Vector2

func _physics_process(delta: float) -> void:
	var input = get_player_input()
	
	velocity = Vector2(
		input.x * move_speed,
		0
	)
	
	move_and_slide(velocity)
	
func get_player_input():
	var input : Vector2
	input.x = Input.get_action_strength("right") - Input.get_action_raw_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("left")
	
	return input
