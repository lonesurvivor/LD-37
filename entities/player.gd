extends KinematicBody2D

onready var g = get_node("/root/global")

var hook_projectile_scene = preload("res://entities/hook.tscn")

onready var interactor_length = get_node("interactor").get_cast_to().length()

onready var movement = get_node("movement")
onready var anim = get_node("anim")

func _ready():
	set_process(true)
	
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

func interact(item):
	var c = get_node("interactor").get_collider()
	if(c and get_node("interactor").is_colliding()): 
		if(c.has_method("on_player_interaction")):
			movement.stop()
			c.on_player_interaction(item)
	elif(item and item.id == "grappling_hook"):
		movement.stop()
		var direction = get_node("interactor").get_cast_to().normalized()
		var hp = hook_projectile_scene.instance()
		g.get_world_node().get_node("scene/entities").add_child(hp)
		hp.set_pos(get_pos())
		hp.throw(direction)
		

func handle_movement_input():
	if g.has_player_control():
		var m = Vector2(0,0)
		if(Input.is_joy_known(0)):
			m = Vector2(Input.get_joy_axis(0, JOY_AXIS_0), Input.get_joy_axis(0, JOY_AXIS_1))
		if(m.length() < 0.2):
			m.x = Input.is_action_pressed("right") - Input.is_action_pressed("left")
			m.y = Input.is_action_pressed("down") - Input.is_action_pressed("up")
		movement.move(m)
	
	

	
	
