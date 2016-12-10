extends Node

export var speed = 80

var prev_state = "idle"
var state = "idle"
var next_state = "idle" setget set_next_state
func set_next_state(state):
	if(next_state == self.state):
		next_state = state
		
#input cache
var move_input = Vector2(0,0) setget move
var principal_moving_direction = "idle"
var prev_principal_moving_direction = "idle"

func move(direction):
	prev_principal_moving_direction = principal_moving_direction
	principal_moving_direction = _get_principal_moving_direction()
	move_input = direction
	
func stop():
	move_input = Vector2(0,0)
	
var knockback = 0

onready var parent = get_parent()

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	prev_state = state
	state = next_state
	
	_do_move(delta)
	
	if(state == "idle"):
		idle_state(delta)
	elif(state == "move"):
		move_state(delta)
		
		
func idle_state(delta):
	if(move_input.length() > 0.001):
		set_next_state("move")
	
func move_state(delta):
	if(move_input.length() < 0.001):
		set_next_state ("idle")
	

func _do_move(delta):
	var by = Vector2(0,0)

	if(knockback == 0):
		by.x = move_input.x * delta * speed
	else:
		by.x = delta * knockback
		knockback /= 1.3
		if(abs(knockback) < 50.0):
			knockback = 0
	
	
	by.y = move_input.y * delta * speed
		
	parent.move(by)
	
	if(parent.is_colliding()):
		var n = parent.get_collision_normal()
		var slide = n.slide(by)
		parent.move(slide)
		
func _get_principal_moving_direction():
	var a = move_input.angle()
	
	if(move_input.length() < 0.001):
		return "idle"
	
	if(a > -PI*3/4 and a < -PI*1/4):
		return "left"
	elif(a > -PI*1/4-0.001 and a < PI*1/4+0.001):
		return "down"
	elif(a > PI*1/4 and a < PI*3/4):
		return "right"
	elif(a > PI*3/4-0.001 or a < -PI*3/4+0.001):
		return "up"
		
func get_principal_moving_direction():
	return principal_moving_direction
		
func has_moving_direction_changed():
	return principal_moving_direction != prev_principal_moving_direction