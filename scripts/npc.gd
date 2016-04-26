extends Sprite


func _ready():
	pass


func show_dialogue():
	get_node("npc_bubble/text_interface_engine").reset()
	get_node("npc_bubble").show()
	get_node("npc_bubble/text_interface_engine").buff_text("Salam aleikum!\n", 0.1)
	get_node("npc_bubble/text_interface_engine").buff_silence(0.1)
	get_node("npc_bubble/text_interface_engine").buff_text("5uie", 0.1)
	get_node("npc_bubble/text_interface_engine").set_state(1)

func hide_dialogue():
	get_node("npc_bubble/text_interface_engine").reset()
	get_node("npc_bubble").hide()