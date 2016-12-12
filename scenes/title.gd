extends Node

var titlesong = preload("res://audio/electric.ogg")

func _ready():
	get_node("player").set_stream(titlesong)
	get_node("player").play()
	
	set_process_input(true)
	
func _input(event):
	if(event.is_action_pressed("ui_accept")):
		get_tree().change_scene("res://scenes/world.tscn")

