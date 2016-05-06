extends Sprite

export var npc_text = StringArray()
var counter = 0

func _ready():
	pass

func show_dialogue():
	if(!self.is_visible()):
		return
	else:
		counter = 0
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
				counter = counter + 1
				break
			counter = counter + 1
		get_node("../npc_bubble/text_interface_engine").set_state(1)

func hide_dialogue():
	get_parent().dialogue_running = false
	get_node("../npc_bubble/text_interface_engine").reset()
	get_node("../npc_bubble").hide()