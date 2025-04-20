extends Node2D
var level = 11
@export var music_stream = preload("res://assets/audio/Music/CiscoIsShite.mp3")


func _ready() -> void:
	if !GameManager.activatedCheckpoint:
		GameManager.level = level
		print(GameManager.level)
		GameManager.activatedCheckpoint = true
		GameManager.currentCheckpoint = null
	AudioManagerScene.play_music_boss_level(music_stream)
	
	
	
