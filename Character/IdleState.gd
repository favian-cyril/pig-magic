extends "res://Character/State.gd"
@export var jump_state: State
@export var create_spell_state: State
@export var jump_velocity = -400.0

func state_input(event: InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	elif (event.is_action_pressed("spell_create")):
		create_spell()

func on_enter():
	playback.travel("move")

func jump():
	if character.is_on_floor():
		character.velocity.y = jump_velocity
	next_state = jump_state
	
func create_spell():
	next_state = create_spell_state
