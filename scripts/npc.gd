extends Sprite


func _ready():
	pass


func show_dialogue():
	get_node("npc_bubble/text_interface_engine").reset()
	get_node("npc_bubble").show()
	if get_parent().item_held == "sprites/key.png":
		get_node("npc_bubble/text_interface_engine").buff_text("You found my key!!! thank you\n", 0.1)
		get_parent().item_held = null

	else:
		get_node("npc_bubble/text_interface_engine").buff_text("Can you find my key son?\n", 0.1)
	get_node("npc_bubble/text_interface_engine").set_state(1)

func hide_dialogue():
	get_node("npc_bubble/text_interface_engine").reset()
	get_node("npc_bubble").hide()