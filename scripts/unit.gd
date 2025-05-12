extends CharacterBody3D

# Import the Players enum
const Players = preload("res://scripts/game_enums.gd").Players

# Unit properties
@export var unit_name: String = "Soldier"
@export var move_range: int = 3
@export var health: int = 10
@export var attack_power: int = 3

# Player assignment
@export var player: Players = Players.PLAYER_1

# Reference to turn manager (explicitly defined)
var turn_manager: Node = null

# Grid position
var grid_x: int = 0
var grid_z: int = 0

# Reference to the grid
var grid: Node = null

func _ready():
	# Set up visual appearance based on player
	var material = StandardMaterial3D.new()
	material.albedo_color = Color.RED if player == Players.PLAYER_1 else Color.BLUE
	$MeshInstance3D.material_override = material

	# Ensure collision detection
	$CollisionShape3D.disabled = false

	# Set up initial position
	if grid:
		position = Vector3(
			grid_x * grid.cell_size + grid.cell_size/2,
			0.5,  # Half height of the unit
			grid_z * grid.cell_size + grid.cell_size/2
		)
	
	# Register with turn manager
	if turn_manager:
		turn_manager.register_unit(self, player)

# Rest of the script remains the same...