extends Node3D

const Players = preload("res://scripts/game_enums.gd").Players

var turn_manager: Node

func _ready():
	# Try to get the TurnManager node
	turn_manager = get_node_or_null("TurnManager")
	
	if not turn_manager:
		# Create TurnManager programmatically if it doesn't exist
		turn_manager = Node.new()
		turn_manager.name = "TurnManager"
		var turn_manager_script = load("res://scripts/turn_manager.gd")
		turn_manager.set_script(turn_manager_script)
		add_child(turn_manager)
	
	# Set up units with grid and turn manager references
	var unit = $Unit
	unit.grid = $Grid
	unit.turn_manager = turn_manager
	unit.move_to_grid(3, 4)
	
	# Create a second unit for the other player
	var unit2 = load("res://scenes/unit.tscn").instantiate()
	unit2.player = Players.PLAYER_2
	unit2.grid = $Grid
	unit2.turn_manager = turn_manager
	unit2.move_to_grid(6, 7)
	add_child(unit2)
	
	# Connect turn manager signals
	turn_manager.connect("turn_started", Callable(self, "_on_turn_started"))
	turn_manager.connect("turn_ended", Callable(self, "_on_turn_ended"))

func _on_turn_started(player):
	print("Turn started for Player ", player + 1)

func _on_turn_ended(player):
	print("Turn ended for Player ", player + 1)

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
