extends Node

onready var g = get_node("/root/global")

var scene_paths = {
	"start" : "res://scenes/start.tscn" 
	}
	
var scenes = Dictionary()

var player_node = null setget set_player_node,get_player_node
func set_player_node(node):
	player_node = node
func get_player_node():
	return player_node

func _ready():
	set_process(true)
	set_process_input(true)
	
	g.world_node = self
	
	for i in scene_paths:
		scenes[i] = load(scene_paths[i])
		
	player_node = load("res://entities/player.tscn").instance()
	switch_scene("start")
	
func _process(delta):
	if(player_node.is_inside_tree()):
		get_node("camera").set_pos(player_node.get_global_pos())
	
func switch_scene(scene):
	var s = get_node("scene")
	if(s):
		if(player_node.is_inside_tree()):
			player_node.get_parent().remove_child(player_node)
		s.queue_free()
		yield(get_tree(), "idle_frame")
	
	var i = scenes[scene].instance()
	i.set_name("scene")
	i.get_node("entities").add_child(player_node)
	add_child(i)
	
# text printing stuff

var text_shown = []
var text_shown_pointer = 0
	
func show_text(text_array):
	g.set_player_control(false)
	get_node("ui/textbox").show()
	text_shown_pointer = 0
	text_shown = text_array
	next_text_page()
	
func next_text_page():
	if(text_shown_pointer >= text_shown.size()):
		get_node("ui/textbox").hide()
		g.set_player_control(true)
	else:
		get_node("ui/textbox/text").set_text(text_shown[text_shown_pointer])
		text_shown_pointer += 1
	
func _input(event):
	if(!g.has_player_control() and get_node("ui/textbox").is_visible()):
		if(event.is_action_pressed("ui_accept")):
			next_text_page()
			
		get_tree().set_input_as_handled()
	
	
