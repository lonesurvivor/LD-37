extends Node

onready var g = get_node("/root/global")

var item1 = null
var item2 = null 

func _match(id1, id2):
	return (item1.id == id1 and item2.id == id2) or (item1.id == id2 and item2.id == id1)
	
func combine(item1, item2):
	self.item1 = item1
	self.item2 = item2
	
	if(_match("hook", "rope")):
		g.inventory_add(g.items.grappling_hook)
		g.inventory_remove("hook")
		g.inventory_remove("rope")
		g.show_text("Wow!")
	elif(_match("sharpening_rock", "dull_machete")):
		g.inventory_add(g.items.machete)
		g.inventory_remove("dull_machete")
#		g.inventory_remove("sharpening_rock")
		g.show_text("Now it is sharp!")
	elif(_match("chainsaw_handle", "dull_blade")):
		g.inventory_add(g.items.dull_machete)
		g.inventory_remove("chainsaw_handle")
		g.inventory_remove("dull_blade")
		g.show_text("Machete!")
	elif(_match("artifact_1", "artifact_2")):
		g.inventory_add(g.items.artifact_3)
		g.inventory_remove("artifact_1")
		g.inventory_remove("artifact_2")
		g.show_text("They fit  together!")

	