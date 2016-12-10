extends StaticBody2D

onready var g = get_node("/root/global")

func _ready():
	pass
	
func on_player_interaction():
	g.get_world_node().show_text(["hallo!", "teste"])
