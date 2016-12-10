extends TextureFrame

const MAX_ITEMS = 10

onready var g = get_node("/root/global")

var background_texture = preload("res://images/inventory_item_background.png")
var background_texture_selected = preload("res://images/inventory_item_background_selected.png")

var selected_slot = -1
var slot_items = []

func _ready():
	g.connect("inventory_changed", self, "_inventory_changed")
	select_slot(-1)

func select_slot(n):
	if(selected_slot >= 0):
		get_node("slot" + str(selected_slot)).set_texture(background_texture)
	selected_slot = n
	if(n >= 0):
		get_node("slot" + str(selected_slot)).set_texture(background_texture_selected)
	
	
func change_slot(relative):
	var n = selected_slot + relative
	if(n > MAX_ITEMS-1):
		n = 0
	elif(n < 0):
		n = MAX_ITEMS-1
	select_slot(n)
	
func deselect_slots():
	select_slot(-1)
	
func get_selected_item():
	if(selected_slot > slot_items.size()-1 or selected_slot < 0):
		return null
	else:
		return slot_items[selected_slot]
	
func _inventory_changed():
	for i in get_children():
		if(i.has_node("image")):
			i.remove_child("image")
	slot_items = []
			
	var c = 0
	for i in g.player_inventory:
		if(c >= MAX_ITEMS):
			print("ERROR: too much items in inv")
		
		var t = TextureFrame.new()
		t.set_name("image")
		t.set_texture(g.player_inventory[i].inventory_texture)
		get_node("slot" + str(c)).add_child(t)
		slot_items.append(g.player_inventory[i])
		c += 1
	
