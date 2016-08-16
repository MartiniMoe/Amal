extends Area2D


export var target_scene = ""
export var dir = 2


func teleport():
	transition.set_direction(dir)
	transition.set_text_counter(0)
	transition.fade_to(target_scene)

func _on_Portal_mouse_enter():
	get_node("Particles2D").set_emitting(true)


func _on_Portal_mouse_exit():
	get_node("Particles2D").set_emitting(false)


func _ready():
	var w = get_node("CollisionShape2D").get_shape().get_extents().width/2
	var h = get_node("CollisionShape2D").get_shape().get_extents().height/2
	get_node("Particles2D").set_emission_half_extents(Vector2(w, h))