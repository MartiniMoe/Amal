
extends Navigation2D

var dragable_dragged = null
var e = null
var process_running = false

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
			if (dragable_dragged == get_node("Sprite 3")):
				var mouse_x = self.get_local_mouse_pos().x
				var mouse_y = self.get_local_mouse_pos().y
				if (mouse_x > (700 - 250) && mouse_x < (700 + 250)):
					if(mouse_y > (250 - 250) && mouse_y < (250 + 250)):
						get_node("Sprite 3").remove_from_group("dragable")
						get_node("Sprite 3").set_pos(Vector2(700,250))
			# end saddle position checking #
			
			process_running = false
		else:
			e = event
			dragable_dragged = check_dragable_dragged(e)
			if (dragable_dragged != null):
				process_running = true
				set_process(true)

func _process(delta):
	dragable_dragged.set_pos(self.get_local_mouse_pos())


func _ready():
	set_process_input(true)