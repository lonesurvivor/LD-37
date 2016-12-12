extends Node

onready var g = get_node("/root/global")

signal text_ended

var current_scene_name = ""
var next_scene_name = ""
var scene_node = null

var scene_paths = {
	"present" : "res://scenes/present.tscn",
	"past" : "res://scenes/past.tscn" 
	}
	
var scenes = Dictionary()
	
var soundtrack_paths = {
	"present" : "res://audio/wastelands.ogg",
	"past" : "res://audio/past.ogg" 
	}
	
var soundtracks = Dictionary()



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
		scenes[i] = load(scene_paths[i]).instance()
		
	for i in soundtrack_paths:
		soundtracks[i] = load(soundtrack_paths[i])
		
	player_node = load("res://entities/player.tscn").instance()
	next_scene_name = "present"
	
	switch_scene_now()
	yield(get_tree(), "idle_frame")
	if(scene_node.has_node("spawn")):
		player_node.set_pos(scene_node.get_node("spawn").get_pos())
		
	show_text("She awakens. Nothing in the vicinity reminds her of anything. Nothing is familiar. Where is she, and when...")
	
func _process(delta):
	if(player_node.is_inside_tree()):
		get_node("camera").set_pos(player_node.get_global_pos())

# scene switching -------------------------------------------------------------------
	
func switch_scene(scene):
	g.set_player_control(false)
	player_node.stop()
	get_node("anim").play("transition")
	next_scene_name = scene
	
func switch_scene_now():
	var s = get_node("scene")
	if(s):
		if(player_node.is_inside_tree()):
			player_node.get_parent().remove_child(player_node)
		for i in s.get_children():
			i.get_parent().remove_child(i)
			
	yield(get_tree(), "idle_frame")
	
	var i = scenes[next_scene_name]
	scene_node = i
	#i.set_name("scene")
	i.get_node("entities").add_child(player_node)
	s.add_child(i)
	
	get_node("player").set_stream(soundtracks[next_scene_name])
	get_node("player").play()
	
	current_scene_name = next_scene_name
	g.set_player_control(true)
	
var text_shown = []
var text_shown_pointer = 0

# text stuff -------------------------------------------------------------------
	
func show_text(text_array):
	player_node.stop()
	if(typeof(text_array) == TYPE_STRING):
		text_array = [text_array]
	g.set_player_control(false)
	get_node("ui/textbox").show()
	text_shown_pointer = 0
	text_shown = text_array
	next_text_page()
	
func next_text_page():
	if(text_shown_pointer >= text_shown.size()):
		get_node("ui/textbox").hide()
		g.set_player_control(true)
		emit_signal("text_ended")
	else:
		get_node("ui/textbox/text").set_text(text_shown[text_shown_pointer])
		text_shown_pointer += 1
		
# most input (except movement) -------------------------------------------------------------------
	
func _input(event):
	if(g.has_player_control()):
		if(event.is_action_pressed("ui_accept")):
			var item = get_node("ui/inventory").get_selected_item()
			player_node.interact(item)
			
		elif(event.is_action_pressed("ui_left")):
			get_node("ui/inventory").change_slot(-1)
		elif(event.is_action_pressed("ui_right")):
			get_node("ui/inventory").change_slot(+1)
		elif(event.is_action_pressed("ui_cancel")):
			get_node("ui/inventory").deselect_slots()
		elif(event.is_action_pressed("ui_combine")):
			var result = get_node("ui/inventory").combine()
			if(result != null):
				g.inventory_combine(result[0], result[1])
		elif(event.is_action_pressed("ui_inspect")):
			var item = get_node("ui/inventory").get_selected_item()
			if(item != null):
				show_text(item.description)
		elif(event.is_action_pressed("ui_page_down")):
			if(current_scene_name == "past"):
				switch_scene("present")
			elif(current_scene_name == "present"):
				switch_scene("past")
	elif(!g.has_player_control() and get_node("ui/textbox").is_visible()):
		if(event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_combine")  or event.is_action_pressed("ui_inspect")):
			next_text_page()
			

			
	get_tree().set_input_as_handled()
	
	
