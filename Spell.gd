extends Area2D

# Speed of the projectile
@export var speed = 400

# Direction of the projectile
var velocity = Vector2.ZERO

func _ready():
	pass

func _process(delta):
	# Move the projectile in the direction of velocity
	if velocity:
		position += velocity * speed * delta
	# Check if the projectile is out of the screen bounds and queue free if so
	#if get_viewport_rect().has_point(position):
		#queue_free()

# Function to initialize the projectile's direction
func initialize(newPosition, direction):
	position = newPosition
	velocity = position.direction_to(direction)
	rotation = position.direction_to(direction).angle()


func _on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body:
		queue_free()
