extends CharacterBody2D
signal projectile(position)
signal pause
@onready var animation_tree = $AnimationTree
@export var SPEED = 100.0
@export var state_machine: CharacterStateMachine

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("walk_left", "walk_right")
	animation_tree.set("parameters/move/blend_position", direction)
	# Prevent walking while creating spell
	if direction && state_machine.current_state.name != "CreateSpell":
		velocity.x = direction * SPEED
		if direction < 0:
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
