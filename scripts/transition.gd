extends Node

var path = ""
var direction
var text_counter = 0
var collectables = 0
var new_path = ""
var conv_pos


# PUBLIC FUNCTION. CALLED WHENEVER YOU WANT TO CHANGE SCENE
func fade_to(scn_path):
	self.path = scn_path # store the scene path
	print("Changing to " + self.path)
	get_node("AnimationPlayer").play("fade") # play the transition animation


# PRIVATE FUNCTION. CALLED AT THE MIDDLE OF THE TRANSITION ANIMATION
func change_scene():
	if path != "":
		get_tree().change_scene(path)

func get_direction():
	return direction

func set_direction(dir):
	direction = dir

func get_collectables():
	return collectables

func set_collectables(collect):
	collectables = collect
	return collectables

func get_text_counter():
	return text_counter

func set_text_counter(counter):
	text_counter = counter
	return text_counter

func get_path():
	return new_path

func set_path(pathName):
	new_path = pathName
	return new_path

func get_convPos():
	return conv_pos

func set_convPos(convPosition):
	conv_pos = convPosition