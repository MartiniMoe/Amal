extends Area2D


export var target_scene = ""
var portal_name = ""
var dir 


func teleport():
	transition.set_direction(direction_value())
	transition.fade_to(target_scene)


func _on_Portal_mouse_enter():
	get_node("Particles2D").set_emitting(true)
	portal_name = self.get_name()
	print(portal_name)


func _on_Portal_mouse_exit():
	get_node("Particles2D").set_emitting(false)


func direction_value():
	if(portal_name == "PortalBack"):
		dir = 0
	if(portal_name == "PortalForward"):
		dir = 1
	if(portal_name == "Portal"):
		dir = 2
	return dir


func _ready():
	var w = get_node("CollisionShape2D").get_shape().get_extents().width/2
	var h = get_node("CollisionShape2D").get_shape().get_extents().height/2
	get_node("Particles2D").set_emission_half_extents(Vector2(w, h))