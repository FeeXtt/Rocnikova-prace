extends Node2D
@export var music_stream = preload("res://assets/audio/Music/CiscoIsShite.mp3")
@onready var player = $Player

func _ready():
	AudioManagerScene.play_music(music_stream)
