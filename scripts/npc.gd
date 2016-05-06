extends Sprite

export var npc_text = StringArray()
var counter = 0
export var path = ""

func _ready():
	counter = transition.get_text_counter()
	pass

func show_dialogue():
	if(!self.is_visible()):
		return
	else:
		get_parent().dialogue_running = true
		get_node("../npc_bubble/text_interface_engine").reset()
		get_node("../npc_bubble").show()
		while (counter < npc_text.size()):
			if(npc_text[counter] == "stop"):
				counter = counter + 1
				break
			else:
				#get_node("../npc_bubble/text_interface_engine").buff_text(npc_text[counter] + "\n", 0.1)
				get_node("../npc_bubble/text_interface_engine").buff_text(npc_text[counter].right(npc_text[counter].find_last("_")+1) + ": ")
				get_node("../npc_bubble/text_interface_engine").buff_text(tr(npc_text[counter]) + "\n", 0.1)
				get_node("../npc_bubble/text_interface_engine").buff_silence(0.1)
			if(npc_text[counter] == "Club_08_Amal"):
				transition.fade_to(path)
				return
			else:
				counter = counter + 1
				break
			counter = counter + 1
		get_node("../npc_bubble/text_interface_engine").set_state(1)

func hide_dialogue():
	get_parent().dialogue_running = false
	get_node("../npc_bubble/text_interface_engine").reset()
	get_node("../npc_bubble").hide()