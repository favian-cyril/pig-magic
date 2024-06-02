extends "res://Character/State.gd"
@export var cast_state: State
@export var idle_state: State
var cast_ui

func state_input(event: InputEvent):
	if (event.is_action_pressed("spell_shoot")):
		character.pause.emit()
		character.process_mode = Node.PROCESS_MODE_INHERIT
		cast_ui.queue_free()
		cast()
	if (event.is_action_pressed("cancel")):
		character.pause.emit()
		character.process_mode = Node.PROCESS_MODE_INHERIT
		cast_ui.queue_free()
		next_state = idle_state

func on_enter():
	playback.travel("create_spell")
	var CastSpell = preload("res://SpellCreate.tscn")
	cast_ui = CastSpell.instantiate()
	character.call_deferred("add_child", cast_ui)
	character.process_mode = Node.PROCESS_MODE_ALWAYS
	character.pause.emit()

func cast():
	next_state = cast_state
