# once you are able to click on the constantly moving cat
# you win this minigame
extends Node

const SPEED = 0.5
var time_left = SPEED

func _input(event):  
	if (event.type == InputEvent.MOUSE_BUTTON):
		if (event.button_index == 1):
			var cat_x = get_node("Cat").get_pos().x
			var cat_y = get_node("Cat").get_pos().y
			var cat_w = get_node("Cat").get_region_rect().size.x
			var cat_h = get_node("Cat").get_region_rect().size.y
			if (event.x > (cat_x - cat_w/2) && event.x < (cat_x + cat_w/2)):
				if(event.y > (cat_y - cat_h/2) && event.y < (cat_y + cat_h/2)):
					get_node("Cat").set_pos(Vector2(1153, 649))
					set_process(false)
					set_fixed_process(false)
					game_state.chased_cat = true
					transition.fade_to(transition.set_path("res://scenes/scene_10_findCat.scn"))
					

# making the cat move constantly #
func _process(delta):
	if (time_left == SPEED):
		var to = Vector2(rand_range(100,1000), rand_range(100,1000))
		get_node("Cat").set_pos(to)

func _fixed_process(delta):
		if (time_left <= 0):
			time_left = SPEED
		else:
			time_left -= delta

func _ready():
	set_process_input(true)
	set_process(true)
	set_fixed_process(true)