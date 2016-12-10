extends KinematicBody2D

onready var g = get_node("/root/global")

onready var interactor_length = get_node("interactor").get_cast_to().length()

onready var movement = get_node("movement")
onready var anim = get_node("anim")

func _ready():
	set_process(true)
	set_process_input(true)
	
	
func _process(delta):
	handle_movement_input()

	if(movement.has_moving_direction_changed()):
		var a = movement.get_principal_moving_direction()
		anim.play(a)
		var ic = Vector2(0,1)
		if(a == "down" or a == "idle_down"):
			ic = Vector2(0,1)
		elif(a == "right" or a == "idle_right"):
			ic = Vector2(1,0)
		elif(a == "up" or a == "idle_up"):
			ic = Vector2(0,-1)
		elif(a == "left" or a == "idle_left"):
			ic = Vector2(-1,0)
			
		get_node("interactor").set_cast_to(ic * interactor_length)

func _input(event):
	if(g.has_player_control()):
		if(event.is_action_pressed("ui_accept")):
			var c = get_node("interactor").get_collider()
			if(c and get_node("interactor").is_colliding()): 
				if(c.has_method("on_player_interaction")):
					c.on_player_interaction()
					
		get_tree().set_input_as_handled()

func handle_movement_input():
	if g.has_player_control():
		var m = Vector2(0,0)
		m.x = Input.is_action_pressed("ui_right") - Input.is_action_pressed("ui_left")
		m.y = Input.is_action_pressed("ui_down") - Input.is_action_pressed("ui_up")
		movement.move(m)
	
	

	
	
