extends Navigation2D

# Member variables
const SPEED = 300.0
const TALK_DISTANCE = 50

var npc_clicked = null

var begin = Vector2()
var end = Vector2()
var path = []


func _process(delta):
	if (path.size() > 1):
		var to_walk = delta*SPEED
		while(to_walk > 0 and path.size() >= 2):
			var pfrom = path[path.size() - 1]
			var pto = path[path.size() - 2]
			var d = pfrom.distance_to(pto)
			if (d <= to_walk):
				path.remove(path.size() - 1)
				to_walk -= d
			else:
				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
				to_walk = 0
		
		var atpos = path[path.size() - 1]
		get_node("character").set_pos(atpos)
		
		if (path.size() < 2):
			path = []
			set_process(false)
			var npc_near = check_npc_near()
			if (npc_near != null && npc_clicked != null) && (npc_clicked == npc_near):
					npc_clicked.show_dialogue()
	else:
		set_process(false)


func check_npc_clicked(clickPos):
	var character = get_node("character")
	for npc in get_children():
		if npc.is_in_group("npc_dialogue"):
			var npc_x = npc.get_pos().x
			var npc_y = npc.get_pos().y
			var npc_width = npc.get_region_rect().size.x
			var npc_height = npc.get_region_rect().size.y
			if (clickPos.x > (npc_x - npc_width/2) && clickPos.x < (npc_x + npc_width/2)):
				if (clickPos.y > (npc_y - npc_height/2) && clickPos.y < (npc_y + npc_height/2)):
					return npc
			npc.hide_dialogue()
	return null


func check_npc_near():
	var character = get_node("character")
	for npc in get_children():
		if npc.is_in_group("npc_dialogue"):
			var npc_x = npc.get_pos().x
			var npc_y = npc.get_pos().y
			var npc_width = npc.get_region_rect().size.x
			var npc_height = npc.get_region_rect().size.y
			if character.get_pos().x > (npc_x - npc_width/2 - TALK_DISTANCE) && character.get_pos().x < (npc_x + npc_width/2 + TALK_DISTANCE):
				if character.get_pos().y > (npc_y - npc_height/2 - TALK_DISTANCE) && character.get_pos().y < (npc_y + npc_height/2 + TALK_DISTANCE):
					return npc
	return null


func _update_path():
	var p = get_simple_path(begin, end, true)
	path = Array(p) # Vector2array too complex to use, convert to regular array
	path.invert()
	
	set_process(true)


func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON and event.pressed and event.button_index == 1):
		begin = get_node("character").get_pos()
		
		npc_clicked = check_npc_clicked(event.pos - get_pos())
		
		# Mouse to local navigation coordinates
		end = event.pos - get_pos()
		_update_path()


func _ready():
	for npc in get_children():
		if npc.is_in_group("npc_dialogue"):
			npc.hide_dialogue()
	set_process_input(true)

