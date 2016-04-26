
extends Panel

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_text_interface_engine_input_event( ev ):
	if ev.type == 3:
		hide()