extends CharacterBody3D

# Unit properties
@export var unit_name: String = "Soldier"
@export var move_range: int = 3
@export var health: int = 10
@export var attack_power: int = 3

# Grid position
var grid_x: int = 0
var grid_z: int = 0

# Reference to the grid
var grid

func _ready():
	# Set up visual appearance
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(0.9, 0.1, 0.1)  # Red for now
	$MeshInstance3D.material_override = material

# Move the unit to a new grid position
func move_to_grid(x: int, z: int):
	grid_x = x
	grid_z = z
	
	if grid:
		position = Vector3(
			grid_x * grid.cell_size + grid.cell_size/2,
			0.5,  # Half height of the unit
			grid_z * grid.cell_size + grid.cell_size/2
		)

# Check if a grid position is within movement range
func is_in_move_range(x: int, z: int) -> bool:
	var distance = abs(x - grid_x) + abs(z - grid_z)
	return distance <= move_range

# Take damage
func take_damage(amount: int) -> bool:
	health -= amount
	if health <= 0:
		die()
		return true
	return false
	
	# Unit death
func die():
	queue_free()
