extends Node

var path = ""
var direction
var text_counter = 0


# PUBLIC FUNCTION. CALLED WHENEVER YOU WANT TO CHANGE SCENE
func fade_to(scn_path):
	self.path = scn_path # store the scene path
	print("Changing to " + self.path)
	get_node("AnimationPlayer").play("fade") # play the transition animation


# PRIVATE FUNCTION. CALLED AT THE MIDDLE OF THE TRANSITION ANIMATION
func change_scene():
	if path != "":
		print("Changing to " + self.path)
		get_tree().change_scene(path)

func get_direction():
	return direction

func set_direction(dir):
	direction = dir
	return direction

func get_text_counter():
	return text_counter

func set_text_counter(counter):
	text_counter = counter
	return text_counter