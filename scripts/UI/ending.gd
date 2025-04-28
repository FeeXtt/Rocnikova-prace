extends Control
@onready var ending = $"."


func _on_button_pressed() -> void:
	if ending.visible:
		if FileAccess.file_exists(GameManager.save_path):
			DirAccess.remove_absolute(GameManager.save_path);
		AudioManagerScene.stop_music()
		get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
		
		
