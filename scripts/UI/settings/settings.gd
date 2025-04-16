extends Control


func _on_audio_button_pressed() -> void:
	AudioManagerScene.stop_music()
	get_tree().change_scene_to_file("res://scenes/UI/settings/audio_setting.tscn")
	

func _on_keyboard_setting_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/settings/keybind_settings.tscn")
	


func _on_controller_settings_button_pressed() -> void:
	pass
	#get_tree().change_scene_to_file()


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
