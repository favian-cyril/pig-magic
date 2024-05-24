extends "res://Character/State.gd"
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var idle_state: State
@export var jump_velocity = -400.0

func state_process(_delta):
	if character.is_on_floor():
		next_state = idle_state

func on_enter():
	playback.travel("jump")
