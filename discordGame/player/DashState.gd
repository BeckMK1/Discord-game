extends State

@export var landing_state : State
@export var ground_state : State
@export var dash_animation : String = "Dash"


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == dash_animation:
		playback.travel("Exit_dash")
		next_state = ground_state
