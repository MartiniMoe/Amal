var path = ""


# PUBLIC FUNCTION. CALLED WHENEVER YOU WANT TO CHANGE SCENE
func fade_to(scn_path):
	self.path = scn_path # store the scene path
	get_node("AnimationPlayer").play("fade") # play the transition animation


# PRIVATE FUNCTION. CALLED AT THE MIDDLE OF THE TRANSITION ANIMATION
func change_scene():
	if path != "":
		get_tree().change_scene(path)