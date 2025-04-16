extends Node2D
@export var music_stream = preload("res://assets/audio/Music/CiscoIsShite.mp3")
@export var level: int

func _ready():
	if !GameManager.activatedCheckpoint:
		GameManager.level = level
		print(GameManager.level)
		GameManager.activatedCheckpoint = true
		GameManager.currentCheckpoint = null
	AudioManagerScene.play_music_boss_level(music_stream)
