extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and $SpellTimer.is_stopped():
		shoot(get_local_mouse_position())
	
func shoot(direction):
	var Projectile = preload("res://Spell.tscn")
	var projectile = Projectile.instantiate()
	$SpellTimer.start()
	$Player.cast()
	call_deferred("add_child", projectile)
	# Initialize the projectile with the direction
	projectile.initialize($Player.position, direction)
