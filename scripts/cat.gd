# once you are able to click on the constantly moving cat
# you win this minigame
extends Node

const CAT_SPEED = 10
const SPEED = 0.1
var speed_timer = 0.0

func _input(event):  
	if (event.type == InputEvent.MOUSE_BUTTON):
		if (event.button_index == 1):
			var cat_x = get_node("Cat").get_pos().x
			var cat_y = get_node("Cat").get_pos().y
			var cat_w = get_node("Cat").get_node("CatSprite").get_region_rect().size.x-150
			var cat_h = get_node("Cat").get_node("CatSprite").get_region_rect().size.y-150
			if (event.x > (cat_x - cat_w/2) && event.x < (cat_x + cat_w/2)):
				if(event.y > (cat_y - cat_h/2) && event.y < (cat_y + cat_h/2)):
					get_node("Cat").set_pos(Vector2(1153, 649))
					set_fixed_process(false)
					game_state.chased_cat = true
					transition.fade_to(transition.set_path("res://scenes/scene_10_findCat.scn"))

var target_location = Vector2(0.0,0.0)
func _fixed_process(delta):
	var cat = get_node("Cat")
	if (target_location - cat.get_pos()).length() < 100:
		target_location = Vector2(rand_range(100, 1800), rand_range(600, 1000))
	var movement = (target_location - cat.get_pos()) * delta * 4
	if movement.x < 0:
		cat.get_node("CatSprite").set_flip_h(true)
	else:
		cat.get_node("CatSprite").set_flip_h(false)
	cat.move(movement)

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	target_location = get_node("Cat").get_pos()