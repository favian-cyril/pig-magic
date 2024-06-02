extends "res://Character/State.gd"
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var idle_state: State
@export var create_spell_state: State
@export var jump_velocity = -400.0

func state_process(_delta):
	if character.is_on_floor():
		next_state = idle_state

func on_enter():
	playback.travel("jump")

func state_input(event: InputEvent):
	if (event.is_action_pressed("spell_create")):
		create_spell()

func create_spell():
	next_state = create_spell_state
