extends KinematicBody2D

onready var movement = get_node("movement")

onready var anim = get_node("anim")

func _ready():
	set_process(true)
	
func _process(delta):
	handle_input()


	if(movement.has_moving_direction_changed()):
		var a = movement.get_principal_moving_direction()
		anim.play(a)

	
	#move elsewhere?
	if(has_node("../camera")):
		get_node("../camera").set_pos(get_global_pos())
	
	

func handle_input():
	var m = Vector2(0,0)
	
	m.x = Input.is_action_pressed("ui_right") - Input.is_action_pressed("ui_left")
	m.y = Input.is_action_pressed("ui_down") - Input.is_action_pressed("ui_up")

	movement.move(m)
	
	
