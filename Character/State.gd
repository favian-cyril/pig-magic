extends Node

class_name State

var character: CharacterBody2D
var next_state: State
var playback: AnimationNodeStateMachinePlayback

func state_input(_event: InputEvent):
	pass

func on_enter():
	pass

func on_exit():
	pass
	
func state_process(_delta):
	pass
