extends Node

class_name PlayerState

@export var can_move : bool = true

var character : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback
var next_state : PlayerState

signal interrupt_state(new_state : State)

func state_process(delta):
	pass

func state_input(event : InputEvent):
	pass

func on_enter():
	pass

func on_exit():
	pass