extends Navigation2D

# Member variables
const SPEED = 160.0
const TALK_DISTANCE = 50

export var scale_enabled = false
export var scale_factor = 500

var npc_clicked = null
var dialogue_running = null

var item_held = null

var begin = Vector2()
var end = Vector2()
var path = []

var left_corner = Vector2(110,1000)
var right_corner = Vector2(1748,1000)
var middle = Vector2(1000,1000)

var mouseOver = null


func _process(delta):
		
	if (path.size() > 1):
		var to_walk = delta*SPEED
		
		if !get_node("player/AnimationPlayer").is_playing():
			get_node("player/AnimationPlayer").play("walk")
		scale_player()
		
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
		get_node("player").set_pos(atpos)
		
		if (path.size() < 2):
			path = []
			get_node("player/AnimationPlayer").seek(0.0, true)
			get_node("player/AnimationPlayer").stop_all()
			set_process(false)
			var npc_near = check_npc_near()
			if !game_state.talked_to_oldWoman && npc_near != null && npc_clicked != null && npc_clicked == npc_near && dialogue_running == false && npc_clicked.is_in_group("oldWoman"):
				game_state.talked_to_oldWoman = true
				npc_clicked.show_dialogue()
				for portal in get_children():
					if portal.is_in_group("portal"):
						portal.show()
				
			
			if get_node("player/Area2D").get_overlapping_areas().size() > 0 && game_state.talked_to_oldWoman:
				get_node("player/Area2D").get_overlapping_areas()[0].teleport()
	else:
		set_process(false)



func check_npc_clicked(clickPos):
	var character = get_node("player")
	for npc in get_children():
		if npc.is_in_group("npc_dialogue"):
			var npc_x = npc.get_pos().x
			var npc_y = npc.get_pos().y
			var npc_width = npc.get_region_rect().size.x
			var npc_height = npc.get_region_rect().size.y
			if (clickPos.x > (npc_x - npc_width/2) && clickPos.x < (npc_x + npc_width/2)):
				if (clickPos.y > (npc_y - npc_height/2) && clickPos.y < (npc_y + npc_height/2)):
					return npc
	return null

func check_npc_near():
	var character = get_node("player")
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
	if (event.type == InputEvent.MOUSE_BUTTON and event.pressed and event.button_index == 1 and !dialogue_running):
		begin = get_node("player").get_pos()
		
		npc_clicked = check_npc_clicked(event.pos - get_pos())
		
		# Mouse to local navigation coordinates
		end = event.pos - get_pos()
		_update_path()

func scale_player():
	if scale_enabled:
		var scale = log(get_node("player").get_pos().y/scale_factor)
		get_node("player").set_scale(Vector2(scale, scale))

func set_playerPos():
	if(transition.get_direction() == 0):
		get_node("player").set_pos(right_corner)
	if(transition.get_direction() == 1):
		get_node("player").set_pos(left_corner)
	if(transition.get_direction() == 2):
		get_node("player").set_pos(middle)
	else:
		return



func _ready():
	set_playerPos()
	scale_player()
	dialogue_running = false
	for npc in get_children():
		if npc.is_in_group("npc_dialogue"):
			npc.hide_dialogue()
	if game_state.talked_to_oldWoman == false:
		for portal in get_children():
					if portal.is_in_group("portal"):
						portal.hide()
	if game_state.chased_cat:
		get_node("npc_test").hide()
	set_process_input(true)



# when pressing the key, collect it #
func _on_Key_pressed():
	item_held = "sprites/key.png"
	get_node("Key").hide()


func npc_bubble_clicked():
	if get_node("npc_bubble/text_interface_engine")._buffer.size() > 0:
		#get_node("npc_bubble/text_interface_engine").set_buff_speed(1.0)
		get_node("npc_bubble/text_interface_engine").set_turbomode(true)
	else:
		if npc_clicked.counter >= npc_clicked.npc_text.size():
			npc_clicked.hide_dialogue()
		else:
			npc_clicked.show_dialogue()