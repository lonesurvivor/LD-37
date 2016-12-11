extends KinematicBody2D

onready var g = get_node("/root/global")

const MAX_RANGE=200

onready var movement = get_node("movement")
onready var player_node = g.get_world_node().get_player_node()

var direction = null
var state = "idle"

func _ready():
	get_node("collision").connect("area_enter", self, "_collision")
	get_node("collision").connect("body_enter", self, "_body_collision")
	set_process(true)
	
var last_d = 0
	
func _process(delta):
	if(state != "idle"):
		var d = (player_node.get_pos() - get_pos()).length()
		if(state == "out"):
			if(d > MAX_RANGE):
				movement.move(-direction)
				state = "in"
		elif(state == "in" or state == "pull"):
			if(d < 5 or d > last_d):
				queue_free()
				g.set_player_control(true)
				player_node.set_layer_mask(1)
				player_node.set_collision_mask(1)
				
		last_d = d
		update()
		
		
func _draw():
	draw_line(Vector2(0,0), Vector2(0,-last_d), Color(0.8,0.8,0.8), 2)
	
func throw(direction):
	g.set_player_control(false)
	player_node.set_layer_mask(2)
	player_node.set_collision_mask(2)
	self.direction = direction
	rotate(Vector2(0,1).angle_to(direction))
	state = "out"
	movement.move(direction)
	
func _collision(other):
	if(other.is_in_group("hook_target")):
		state = "pull"
		last_d = (player_node.get_pos() - get_pos()).length()
		movement.stop()
		player_node.movement.move(-2*(player_node.get_pos() - get_pos()).normalized())
		
func _body_collision(other):
	if(other.is_in_group("hook_target")):
		state = "pull"
		last_d = (player_node.get_pos() - get_pos()).length()
		movement.stop()
		player_node.movement.move(-2*(player_node.get_pos() - get_pos()).normalized())
