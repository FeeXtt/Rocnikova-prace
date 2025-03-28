extends Control

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func _on_startgame_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/saves.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/settings/settings.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
	
