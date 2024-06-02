extends Node

class_name CharacterStateMachine
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var character: CharacterBody2D
@export var current_state: State
@export var animation_tree: AnimationTree
var states: Array[State]
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if (child is State):
			states.append(child)
			child.character = character
			child.playback = animation_tree["parameters/playback"]
		else:
			push_warning("Child " + child.name + " is not a state")

func _physics_process(delta):
	if (current_state.next_state != null):
		switch_states(current_state.next_state)
	current_state.state_process(delta)
	# Gravity should apply to all states but freeze on CreateSpell
	if current_state.name == 'CreateSpell':
		character.velocity.y = 0
	elif not character.is_on_floor():
		character.velocity.y += gravity * delta

func switch_states(state: State):
	if (current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	current_state = state
	current_state.on_enter()

func _input(event: InputEvent):
	current_state.state_input(event)
