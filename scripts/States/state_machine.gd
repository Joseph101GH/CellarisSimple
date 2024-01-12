extends Node

@export var initial_state : State
@export var enemy: CharacterBody2D

var current_state : State
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)

	if initial_state:
		set_parameters_and_enter(initial_state)

func set_parameters_and_enter(state: State):
	if state is EnemyIdle or state is EnemyFollow:
		state.set_parameters(enemy)
	state.Enter()
	current_state = state

func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return

	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return

	if current_state:
		current_state.Exit()

	set_parameters_and_enter(new_state)
