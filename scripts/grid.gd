extends Node3D

# Grid properties
@export var grid_size_x: int = 10
@export var grid_size_z: int = 10
@export var cell_size: float = 1.0

# Visual properties
@export var grid_color: Color = Color(0.2, 0.2, 0.2)
@export var highlight_color: Color = Color(0.0, 0.5, 1.0, 0.5)

# References to reused nodes
var grid_mesh_instance: MeshInstance3D
var highlight_mesh_instance: MeshInstance3D

# Called when the node enters the scene tree
func _ready():
	create_grid_mesh()
	create_highlight_mesh()

# Creates the visual grid lines
func create_grid_mesh():
	# Create a new ImmediateMesh for drawing lines
	var mesh = ImmediateMesh.new()
	grid_mesh_instance = MeshInstance3D.new()
	grid_mesh_instance.mesh = mesh
	add_child(grid_mesh_instance)
	
	# Create material for the grid lines
	var material = StandardMaterial3D.new()
	material.shading_mode = StandardMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = grid_color
	material.transparency = StandardMaterial3D.TRANSPARENCY_ALPHA
	grid_mesh_instance.material_override = material
	
	# Draw grid lines
	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	
	# Draw X lines
	for x in range(grid_size_x + 1):
		var start_pos = Vector3(x * cell_size, 0.01, 0)
		var end_pos = Vector3(x * cell_size, 0.01, grid_size_z * cell_size)
		mesh.surface_add_vertex(start_pos)
		mesh.surface_add_vertex(end_pos)
	
	# Draw Z lines
	for z in range(grid_size_z + 1):
		var start_pos = Vector3(0, 0.01, z * cell_size)
		var end_pos = Vector3(grid_size_x * cell_size, 0.01, z * cell_size)
		mesh.surface_add_vertex(start_pos)
		mesh.surface_add_vertex(end_pos)
	
	mesh.surface_end()

# Creates a mesh for highlighting cells
func create_highlight_mesh():
	var mesh = QuadMesh.new()
	mesh.size = Vector2(cell_size, cell_size)
	
	highlight_mesh_instance = MeshInstance3D.new()
	highlight_mesh_instance.mesh = mesh
	highlight_mesh_instance.rotation_degrees.x = -90  # Make it face up
	highlight_mesh_instance.visible = false
	add_child(highlight_mesh_instance)
	
	# Create material for highlights
	var material = StandardMaterial3D.new()
	material.shading_mode = StandardMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = highlight_color
	material.transparency = StandardMaterial3D.TRANSPARENCY_ALPHA
	highlight_mesh_instance.material_override = material

# Highlights a cell at the given grid coordinates
func highlight_cell(grid_x: int, grid_z: int):
	if grid_x >= 0 and grid_x < grid_size_x and grid_z >= 0 and grid_z < grid_size_z:
		highlight_mesh_instance.visible = true
		highlight_mesh_instance.position = Vector3(
			grid_x * cell_size + cell_size/2, 
			0.02,  # Slightly above the grid
			grid_z * cell_size + cell_size/2
		)

# Clears the highlight
func clear_highlight():
	highlight_mesh_instance.visible = false

# Convert a world position to grid coordinates
func world_to_grid(world_pos: Vector3) -> Vector2:
	var grid_x = int(world_pos.x / cell_size)
	var grid_z = int(world_pos.z / cell_size)
	return Vector2(grid_x, grid_z)
