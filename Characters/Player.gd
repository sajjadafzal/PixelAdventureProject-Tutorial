extends KinematicBody2D

export(float) var move_speed = 200
export(float) var jump_impulse = 600

enum STATE {IDLE, RUN, JUMP}

var velocity : Vector2

var current_state = STATE.IDLE setget set_current_state
var jumps = 0

func _physics_process(delta: float) -> void:
	var input = get_player_input()
	
	velocity = Vector2(
		input.x * move_speed,
		min(velocity.y + GameSettings.gravity,GameSettings.terminal_velocity)
	)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	pick_next_state()
	print(current_state)
	
func pick_next_state():
	if(is_on_floor()):
		jumps = 0
		
		if (Input.is_action_just_pressed("jump")):
			self.current_state = STATE.JUMP
		elif (abs(velocity.x) > 0):
			self.current_state = STATE.RUN
		else:
			self.current_state = STATE.IDLE
	
	else:
		#TODO Double jump
		pass
			
func get_player_input():
	var input : Vector2
	input.x = Input.get_action_strength("right") - Input.get_action_raw_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("left")
	
	return input

#SETTERS

func set_current_state(new_state):
	match(new_state):
		STATE.JUMP:
			jump()
		
	current_state = new_state
	
func jump():
	velocity.y = -jump_impulse
	jumps += 1
