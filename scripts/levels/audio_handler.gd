extends Node2D
@export var music_stream = preload("res://assets/audio/Music/CiscoIsShite.mp3")
@onready var player = $Player

func _ready():
	GameManager.BASE_JUMP_FORCE = -350
	GameManager.DOUBLE_JUMP_FORCE= -350
	GameManager.GRAVITY = 1
	AudioManagerScene.play_music(music_stream)
