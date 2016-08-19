
extends Navigation2D

var dragable_dragged = null
var e = null
var process_running = false
var counter = 0

func check_dragable_dragged(e):
	for g in get_children():
		if g.is_in_group("dragable"):
			var g_x = g.get_pos().x
			var g_y = g.get_pos().y
			var g_w = g.get_region_rect().size.x
			var g_h = g.get_region_rect().size.y
			if (e.x > (g_x - g_w/2) && e.x < (g_x + g_w/2)):
				if(e.y > (g_y - g_h/2) && e.y < (g_y + g_h/2)):
					return g;
	return null;

func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON):
		if (process_running):
			set_process(false)
			
			# check if the saddle is in the correct position #
			check_correct_node("Saddle", 716, 309)
			#if (!get_node("Wheel2").get_pos() == Vector2(1280, 690)):
			#	check_correct_node("Wheel1", 1280, 690)
			#if (!get_node("Wheel1").get_pos() == Vector2(875, 710)):
			#	check_correct_node("Wheel2", 875, 710)
			#if (!get_node("Wheel1").get_pos() == Vector2(1280, 690)):
			#	check_correct_node("Wheel2", 1280, 690)
			#if (!get_node("Wheel2").get_pos() == Vector2(875, 710)):
			#	check_correct_node("Wheel1", 875, 710)
			check_correct_node("Wheel1", 554, 636)
			check_correct_node("Wheel2", 1238, 636)
			check_correct_node("Handle", 1069, 255)
			check_correct_node("Body", 888, 486)
			check_correct_node("Peddle", 848, 664)
			# end saddle position checking #
			
			process_running = false
		else:
			e = event
			dragable_dragged = check_dragable_dragged(e)
			if (dragable_dragged != null):
				process_running = true
				set_process(true)


func check_correct_node(node, x, y):
	var drop_area_size = 250
	if (dragable_dragged == get_node(node)):
			var mouse_x = self.get_local_mouse_pos().x
			var mouse_y = self.get_local_mouse_pos().y
			# 250 is just how large the drop area is #
			if (mouse_x > (x - drop_area_size) && mouse_x < (x + drop_area_size)):
				if(mouse_y > (y - drop_area_size) && mouse_y < (y + drop_area_size)):
					get_node(node).remove_from_group("dragable")
					get_node(node).set_pos(Vector2(x, y))
					get_node(node).set_opacity(1)
					counter = counter + 1
					print(counter)
					if (counter >= 6):
						game_state.bike = true
						transition.fade_to(transition.set_path("res://scenes/scene_07_entrance_youthClub.scn"))

func _process(delta):
	dragable_dragged.set_pos(self.get_local_mouse_pos())
	


func _ready():
	set_process_input(true)