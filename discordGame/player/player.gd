extends CharacterBody2D

@export var dash_speed : float = 1500.0
const WALK_SPEED = 200
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var state_machine : PlayerStateMachine = $PlayerStateMachine
@onready var dash_timer = %dashDuration
@onready var dash_cd = %dashCD


var dash_direction
var direction 
func _physics_process(delta):
	velocity.y += delta * gravity
	
	direction = Input.get_axis("move_left", "move_right")
	
	if state_machine.current_state.name != "Dash":
		if direction != 0 && state_machine.check_if_can_move():
			velocity.x = WALK_SPEED * direction
		else:
			velocity.x = 0
		
	if Input.is_action_just_pressed("dash") && is_on_floor():
		var current_direction = direction
		if direction != 0 && state_machine.check_if_can_dash():
			dash_timer.start()
			dash_cd.start()
			velocity.x = dash_speed * current_direction
			state_machine.current_state.can_dash = false 
			return
		if direction != 0:
			velocity.x = 0
			return
			
	move_and_slide()
	update_animation()



func _ready():
	animation_tree.active = true

func update_animation():
	animation_tree.set("parameters/Walk/blend_position", direction)



func _on_dash_cd_timeout():
	state_machine.current_state.can_dash = true 
