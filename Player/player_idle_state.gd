extends PlayerState

class_name GroundState

@export var jump_velocity : float = -350.0
@export var dash_state : PlayerState
@export var attack_state : PlayerState
@export var attack_node : String = "attack1"

@onready var buffer_timer : Timer = $BufferTimer


func state_input(event : InputEvent):
	if(event.is_action_pressed("dash")):
		print("jump")
		jump()
	if(event.is_action_pressed("left_click")):
		attack()
		
func jump():
	print("going into next dash state")
	next_state = dash_state

func attack():
	next_state = attack_state
