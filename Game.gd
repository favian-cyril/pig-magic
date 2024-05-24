extends Node2D

func _on_player_projectile(pos):
	var Projectile = preload("res://Spell.tscn")
	var projectile = Projectile.instantiate()
	call_deferred("add_child", projectile)
	# Initialize the projectile with the direction
	projectile.initialize(pos, get_local_mouse_position())



func _on_player_pause():
	get_tree().paused = !get_tree().paused
