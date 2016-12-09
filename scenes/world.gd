extends Node

onready var g = get_node("/root/global")

var scene_paths = {
	"start" : "res://scenes/start.tscn" 
	}
	
var scenes = Dictionary()

func _ready():
	g.world_node = self
	
	for i in scene_paths:
		scenes[i] = load(scene_paths[i])
		
	switch_scene("start")
	
func switch_scene(scene):
	if(has_node("scene")):
		get_node("scene").queue_free()
		yield(get_tree(), "idle_frame")
	
	var i = scenes[scene].instance()
	i.set_name("scene")
	add_child(i)
	
