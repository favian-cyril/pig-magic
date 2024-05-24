extends "res://Character/State.gd"
@export var cast_state: State

func state_input(event: InputEvent):
	if (event.is_action_pressed("spell_shoot")):
		character.pause.emit()
		character.process_mode = Node.PROCESS_MODE_INHERIT
		cast()

func on_enter():
	playback.travel("create_spell")
	character.process_mode = Node.PROCESS_MODE_ALWAYS
	character.pause.emit()

func cast():
	next_state = cast_state
