extends Node

onready var combinations = get_node("/root/combinations")

var player_inventory = Dictionary()
var Item = preload("res://scripts/item.gd")

signal inventory_changed

func inventory_add(item):
	if(player_inventory.size() >= 10):
		print("ERROR: inventory full")
		return
		
	if(player_inventory.has(item.id)):
		print("ERROR: item already in inventory")
		return
		
	player_inventory[item.id] = item
	emit_signal("inventory_changed")
		
func inventory_remove(item_id):
	if(!player_inventory.has(item_id)):
		print("ERROR: no item with id " + item_id + "in inventory")
		return
		
	player_inventory.erase(item_id)
	emit_signal("inventory_changed")
	
func inventory_has(item_id):
	return player_inventory.has(item_id)
	
func inventory_combine(item1, item2):
	var r = combinations.combine(item1, item2)

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
	
func show_text(text_array):
	if(world_node):
		world_node.show_text(text_array)