extends Sprite

var marbles_collected = 0
var marble_clicked = null
var marble_hovered = null

func check_marble_clicked(e):
	for marble in get_children():
		if marble.is_in_group("marbles"):
			var m_x = marble.get_pos().x
			var m_y = marble.get_pos().y
			var m_w = marble.get_region_rect().size.x
			var m_h = marble.get_region_rect().size.y
			if (e.x > (m_x - m_w/2) && e.x < (m_x + m_w/2)):
				if(e.y > (m_y - m_h/2) && e.y < (m_y + m_h/2)):
					return marble;
	return null;


func check_marble_hovered(e):
	for marble in get_children():
		if marble.is_in_group("marbles"):
			var m_x = marble.get_pos().x
			var m_y = marble.get_pos().y
			var m_w = marble.get_region_rect().size.x
			var m_h = marble.get_region_rect().size.y
			if (e.x > (m_x - m_w/2) && e.x < (m_x + m_w/2)):
				if (e.y > (m_y - m_h/2) && e.y < (m_y + m_h/2)):
					return marble;
	return null;


func _input(event):
	if (event.type == InputEvent.MOUSE_MOTION):
		marble_hovered = check_marble_hovered(event)
		if (marble_hovered != null):
			marble_hovered.set_opacity(1)
	
	if (event.type == InputEvent.MOUSE_BUTTON && event.button_index == 1):
		marble_clicked = check_marble_clicked(event)
		if (marble_clicked != null):
			marble_clicked.set_hidden(true)
			marbles_collected += 1



func _ready():
	set_process_input(true)