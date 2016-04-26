extends Navigation2D

# Member variables
const SPEED = 300.0
const TALK_DISTANCE = 50

var testNpcClicked = false

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
			print("path complete")
			if checkTestNpcNear() && testNpcClicked:
				get_node("npc_test/npc_bubble/text_interface_engine").reset()
				get_node("npc_test/npc_bubble").show()
				get_node("npc_test/npc_bubble/text_interface_engine").buff_text("Salam aleikum!\n", 0.1)
				get_node("npc_test/npc_bubble/text_interface_engine").buff_silence(0.1)
				get_node("npc_test/npc_bubble/text_interface_engine").buff_text("5uie", 0.1)
				get_node("npc_test/npc_bubble/text_interface_engine").set_state(1)
	else:
		set_process(false)


func checkTestNpcClicked(clickPos):
	var character = get_node("character")
	var npc = get_node("npc_test")
	var npc_x = npc.get_pos().x
	var npc_y = npc.get_pos().y
	var npc_width = npc.get_region_rect().size.x
	var npc_height = npc.get_region_rect().size.y
	if (clickPos.x > (npc_x - npc_width/2) && clickPos.x < (npc_x + npc_width/2)):
		if (clickPos.y > (npc_y - npc_height/2) && clickPos.y < (npc_y + npc_height/2)):
			return true
	return false


func checkTestNpcNear():
	var character = get_node("character")
	var npc = get_node("npc_test")
	var npc_x = npc.get_pos().x
	var npc_y = npc.get_pos().y
	var npc_width = npc.get_region_rect().size.x
	var npc_height = npc.get_region_rect().size.y
	if character.get_pos().x > (npc_x - npc_width/2 - TALK_DISTANCE) && character.get_pos().x < (npc_x + npc_width/2 + TALK_DISTANCE):
		if character.get_pos().y > (npc_y - npc_height/2 - TALK_DISTANCE) && character.get_pos().y < (npc_y + npc_height/2 + TALK_DISTANCE):
			return true
	return false


func _update_path():
	var p = get_simple_path(begin, end, true)
	path = Array(p) # Vector2array too complex to use, convert to regular array
	path.invert()
	
	set_process(true)


func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON and event.pressed and event.button_index == 1):
		begin = get_node("character").get_pos()
		
		if checkTestNpcClicked(event.pos - get_pos()):
			testNpcClicked = true
			print("npc clicked")
		else:
			testNpcClicked = false
			print("npc not clicked")
		
		# Mouse to local navigation coordinates
		end = event.pos - get_pos()
		_update_path()


func _ready():
	get_node("npc_test/npc_bubble").hide()
	set_process_input(true)

