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
		g.show_text("An awesome grappling hook. Arrrr.")
		g.inventory_add(g.items.grappling_hook)
		g.inventory_remove("hook")
		g.inventory_remove("rope")
	elif(_match("sharpening_rock", "dull_machete")):
		g.inventory_add(g.items.machete)
		g.inventory_remove("dull_machete")
#		g.inventory_remove("sharpening_rock")
		g.show_text("Now it is sharp!")
		g.get_world_node().get_node("samples").play("blade")
	elif(_match("chainsaw_handle", "dull_blade")):
		g.inventory_add(g.items.dull_machete)
		g.inventory_remove("chainsaw_handle")
		g.inventory_remove("dull_blade")
		g.show_text("They fit.")
		g.get_world_node().get_node("samples").play("assembly_machete")
	elif(_match("artifact_1", "artifact_2")):
		g.inventory_add(g.items.artifact_3)
		g.inventory_remove("artifact_1")
		g.inventory_remove("artifact_2")
		g.get_world_node().get_node("samples").play("artifact_complete")
		g.show_text("It fits.")
	else:
		g.show_text("These don't fit together")

	