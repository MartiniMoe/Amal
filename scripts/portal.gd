extends Area2D


export var target_scene = ""


func teleport():
	transition.fade_to(target_scene)


func _on_Portal_mouse_enter():
	get_node("enter_scene").show()


func _on_Portal_mouse_exit():
	get_node("enter_scene").hide()