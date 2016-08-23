extends Panel


func _on_btn_english_pressed():
	TranslationServer.set_locale("en")
	transition.fade_to("res://scenes/scene_01_entrance.scn")


func _on_btn_arabic_pressed():
	TranslationServer.set_locale("ar")
	transition.fade_to("res://scenes/scene_01_entrance.scn")

func _on_btn_exit_pressed():
	get_tree().quit()

func _on_btn_german_pressed():
	TranslationServer.set_locale("de")
	transition.fade_to("res://scenes/scene_01_entrance.scn")

func _on_btn_esperanto_pressed():
	TranslationServer.set_locale("sr")
	transition.fade_to("res://scenes/scene_01_entrance.scn")