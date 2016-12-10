var id = ""
var name = ""
var description = ""
var inventory_texture = null
var world_texture = null

func _init(id, name, description, it_path):
	self.id = id
	self.name= name
	self.description = description
	inventory_texture = load(it_path)
