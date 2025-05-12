extends Node

# Import the Players enum
const Players = preload("res://scripts/game_enums.gd").Players

# Current active player
var current_player: Players = Players.PLAYER_1

# Tracks units for each player
var player_units = {
	Players.PLAYER_1: [],
	Players.PLAYER_2: []
}

# Signals for turn management
signal turn_started(player)
signal turn_ended(player)

func _ready():
	# Initial turn setup
	emit_signal("turn_started", current_player)

# Add a unit to a player's roster
func register_unit(unit, player: Players):
	player_units[player].append(unit)

# End the current turn
func end_turn():
	emit_signal("turn_ended", current_player)
	
	# Switch to next player
	current_player = Players.PLAYER_1 if current_player == Players.PLAYER_2 else Players.PLAYER_2
	
	emit_signal("turn_started", current_player)
	print("Turn switched to Player ", current_player + 1)

# Get current active player
func get_current_player() -> Players:
	return current_player

# Check if it's a specific player's turn
func is_player_turn(player: Players) -> bool:
	return current_player == player
