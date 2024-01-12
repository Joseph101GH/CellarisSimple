extends PlayerState

class_name DashState

@export var dash_acceleration : float = 8
@export var dash_duration : float = 0.3
@export var idle_state : PlayerState
var dash_timer : float = 0.0
var dash_direction : Vector2


func on_enter():
	print("dash entered")
	can_move = false  # Player cannot move during dash, handled by dash logic
	dash_timer = dash_duration
	dash_direction = character.get_input_direction().normalized()
	
	if dash_direction == Vector2.ZERO:
		# If there's no input direction, dash towards the mouse position
		var mouse_global_position = character.get_global_mouse_position()
		dash_direction = (mouse_global_position - character.global_position).normalized()

	# Initialize the dash by setting an initial velocity
	character.velocity = dash_direction * dash_acceleration * get_physics_process_delta_time()

func state_process(delta):
	if dash_timer > 0:
		dash_timer -= delta
		# Gradually decrease the acceleration effect over time
		var dash_effect = (dash_acceleration * 10000) * delta * (dash_timer / dash_duration)
		character.velocity += dash_direction * dash_effect
		character.move_and_slide()
	else:
		# Dash is over, notify the state machine to change state
		next_state = idle_state

func on_exit():
	# Reset velocity and other properties if needed
	character.velocity = Vector2.ZERO
