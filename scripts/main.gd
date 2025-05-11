extends Node3D

func _ready():
	print("Exyst - 3D Project initialized successfully!")
	
func _process(delta):
	# Quit game with Escape key
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	# Simple rotation for the cylinder unit (adjust the node path as needed)
	# Note: In Godot 4.4.1, it's better to use node paths for reliability
	var unit = $CSGCylinder3D  # This assumes you didn't rename the cylinder
	if unit:
		unit.rotate_y(delta * 1.0)  # Slow rotation
