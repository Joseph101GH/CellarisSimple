extends PlayerState

class_name GroundState

@export var dash_velocity : float = -350.0
@export var air_state : State
@export var dash_animation : String = "dash"
@export var attack_state : State
@export var attack_node : String = "attack1"

@onready var buffer_timer : Timer = $BufferTimer



func state_input(event : InputEvent):
	if(event.is_action_pressed("dash")):
		dash()
	if(event.is_action_pressed("attack")):
		attack()
		
func dash():
	character.velocity.y = dash_velocity
	next_state = air_state
	playback.travel(dash_animation)

func attack():
	next_state = attack_state
	playback.travel(attack_node)
