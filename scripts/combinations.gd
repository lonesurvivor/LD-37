extends Node

onready var g = get_node("/root/global")

var item1 = null
var item2 = null 

func _match(id1, id2):
	return (item1.id == id1 and item2.id == id2) or (item1.id == id2 and item2.id == id1)
	
func combine(item1, item2):
	self.item1 = item1
	self.item2 = item2
	
	if(_match("a", "b")):
		g.show_text(["Zwei Kettensägen sind besser als eine"])
		g.inventory_remove("a")
	elif(_match("b", "grappling_hook")):
		pass

	