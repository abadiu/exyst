extends Node3D

var current_highlight = Vector2(-1, -1)

func _ready():
	print("Exyst - 3D Project initialized successfully!")
	
	# Set up unit with reference to grid
	$Unit.grid = $Grid
	$Unit.move_to_grid(3, 4)  # Place unit at grid position (3,4)
	
func _process(delta):
	# Quit game with Escape key
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	# Handle mouse interaction with the grid
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_pos = get_viewport().get_mouse_position()
		var from = $Camera3D.project_ray_origin(mouse_pos)
		var to = from + $Camera3D.project_ray_normal(mouse_pos) * 1000
		
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, to)
		var result = space_state.intersect_ray(query)
		
		if result:
			var grid_pos = $Grid.world_to_grid(result.position)
			if grid_pos != current_highlight:
				current_highlight = grid_pos
				$Grid.highlight_cell(int(grid_pos.x), int(grid_pos.y))
				print("Selected grid cell: ", grid_pos)
