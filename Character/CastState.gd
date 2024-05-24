extends "res://Character/State.gd"
@export var idle_state: State

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == "cast"):
		next_state = idle_state

func on_enter():
	playback.travel("cast")
	character.projectile.emit(character.position)
