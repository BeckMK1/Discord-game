extends Label

@export var state_machine : PlayerStateMachine

func _process(delta):
	if state_machine.current_state.can_dash:
		text = "can dash: true"
	if !state_machine.current_state.can_dash:
		text = "can dash: false" 
