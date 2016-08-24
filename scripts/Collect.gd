extends Navigation2D

var items_collected = 0
var item_clicked = null
var item_hovered = null
var items_collectable = 0
export var path = ""
export var collectableObject = ""

func check_item_clicked(e):
	for item in get_children():
		if item.is_in_group("collectable"):
			var m_x = item.get_pos().x
			var m_y = item.get_pos().y
			var m_w = item.get_region_rect().size.x
			var m_h = item.get_region_rect().size.y
			if (e.x > (m_x - m_w/2) && e.x < (m_x + m_w/2)):
				if(e.y > (m_y - m_h/2) && e.y < (m_y + m_h/2)):
					return item;
	return null;


func check_item_hovered(e):
	for item in get_children():
		if item.is_in_group("collectable"):
			var m_x = item.get_pos().x
			var m_y = item.get_pos().y
			var m_w = item.get_region_rect().size.x
			var m_h = item.get_region_rect().size.y
			if (e.x > (m_x - m_w/2) && e.x < (m_x + m_w/2)):
				if (e.y > (m_y - m_h/2) && e.y < (m_y + m_h/2)):
					return item;
	return null;


func _input(event):
	if (event.type == InputEvent.MOUSE_MOTION):
		item_hovered = check_item_hovered(event)
		if (item_hovered != null):
			item_hovered.set_opacity(1)
		else:
			for item in get_children():
				if (item.is_in_group("collectable")):
					item.set_opacity(0.4)
	
	if (event.type == InputEvent.MOUSE_BUTTON && event.pressed && event.button_index == 1):
		item_clicked = check_item_clicked(event)
		if (item_clicked != null):
			item_clicked.set_hidden(true)
			items_collected += 1
			if(items_collected >= transition.get_collectables()):
				if(collectableObject == "marbles"):
					game_state.collected_marbles = true
				if(collectableObject == "computer"):
					game_state.collected_computer = true
					transition.set_direction(3)
				transition.get_text_counter()
				transition.fade_to(transition.get_path())
				

func _ready():
	set_process_input(true)