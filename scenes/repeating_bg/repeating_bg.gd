tool
extends Control

export(String, FILE, "*.png") var image_path = ""
export(NodePath) var transparency_mask_path = "transparency_mask"

var max_elements = Vector2(30,30)

var initialized = false
var first = true

var image = Image()
var large_image = Image()
onready var large_image_texture = ImageTexture.new()
var transparency_mask = null

func _ready():
	if(!initialized):
		initialized = true
		transparency_mask = get_node(transparency_mask_path)
	changed()
	
	#changed()

func changed():
	if(!initialized or image_path == ""):
		return

	image.load(image_path)
#
	var iw = image.get_width()
	var ih = image.get_height()
#
	var size_x = min(ceil(get_size().x / iw), max_elements.x)
	var size_y = min(ceil(get_size().y / ih), max_elements.y)
#
	large_image = Image(size_x*iw, size_y*ih, false, image.get_format())
#
	for i in range(size_x-1):
		for j in range(size_y-1):
			large_image.blit_rect(image, Rect2(0,0,iw,ih), Vector2(i*iw,j*ih))
#
	large_image_texture.create_from_image(large_image, 0)

	if(first):
		if(!get_tree().is_editor_hint()):
			var vp = Viewport.new()
			vp.set_as_render_target(true)
			vp.set_transparent_background(true)
			vp.set_use_own_world(true)
			get_parent().call_deferred("add_child", vp)
			
			get_node(transparency_mask_path + "/..").call_deferred("remove_child", transparency_mask)
			vp.call_deferred("add_child", transparency_mask)
			yield(get_tree(), "idle_frame")
	
			vp.set_rect(Rect2(0,0,size_x*iw, size_y*ih))
	
			vp.queue_screen_capture()
			yield(get_tree(), "idle_frame")
			yield(get_tree(), "idle_frame")
	
			var tm_sc = vp.get_screen_capture()
			var tm_texture = ImageTexture.new()
			tm_texture.create_from_image(tm_sc,0)
	
			get_material().set_shader_param("mask", tm_texture)
			get_material().set_shader_param("rel_mask_size", Vector2(tm_texture.get_width()/large_image_texture.get_width(), tm_texture.get_height()/large_image_texture.get_height()))
	
			vp.queue_free()
			
		else:
			#make sure the shader is disabled in tool mode
			set_material().set_shader_param("rel_mask_size", Vector2(0,0))
			
		first = false


func _draw():
	draw_texture(large_image_texture, Vector2(0,0))

func _on_resized():
	changed()

