extends Control

@export var music_stream = preload("res://assets/audio/Music/DatabaseSoundTrack.mp3")

func _ready() -> void:
	AudioManagerScene.play_music(music_stream)
	
func _process(_delta: float) -> void:
	pass

func _on_startgame_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/saves.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/settings/settings.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
	
