extends State

class_name GroundState

@export var jump_speed : float = -500.0
@export var air_state : State
@export var dash_state : State
@export var jump_animation : String = "Jump"
@export var dash_animation : String = "Dash"

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	if event.is_action_pressed("dash"):
		dash()
		
func state_process(delta):
	if(!character.is_on_floor()):
		next_state = air_state
		
func jump():
	character.velocity.y = jump_speed
	next_state = air_state
	playback.travel(jump_animation)

func dash():
	if character.is_on_floor() && can_dash:
		playback.travel(dash_animation)
		next_state = dash_state
		
	
