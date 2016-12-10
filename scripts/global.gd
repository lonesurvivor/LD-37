extends Node

var world_node = null setget set_world_node,get_world_node
func set_world_node(node):
	world_node = node
func get_world_node():
	return world_node
	
var player_control = true setget set_player_control,has_player_control
func set_player_control(c):
	player_control = c
func has_player_control():
	return player_control