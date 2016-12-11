extends Node

const MAX_ITEMS = 10

onready var combinations = get_node("/root/combinations")
onready var items = get_node("/root/items")

var player_inventory = Dictionary()
var keys = Dictionary()

signal inventory_changed

# set nodes -------------------------------------------------------------------

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

# inventory -------------------------------------------------------------------

func inventory_add(item):
	if(player_inventory.size() >= MAX_ITEMS):
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
	emit_signal("inventory_changed")
	
# "keywords" -------------------------------------------------------------------
	
func add_key(key, value):
	keys[key] = value
	
func has_key(key):
	return keys.has(key)
	
func get_key(key):
	if(has_key(key)):
		return keys[key]
	else:
		return null
		
func remove_key(key):
	if(has_key(key)):
		keys.erase(key)

# text shortcut -------------------------------------------------------------------
	
func show_text(text_array):
	if(world_node):
		world_node.show_text(text_array)