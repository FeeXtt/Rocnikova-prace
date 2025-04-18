extends Node2D
@export var music_stream = preload("res://assets/audio/Music/CiscoIsShite.mp3")
@export var level: int
@onready var bossbound = $BossBound
@onready var ground = $TileMap/Ground
@onready var platform1 = $TileMap/plaformsLayer1
@onready var platform2 = $TileMap/plaformsLayer2
@onready var warningmark_ground = $Exclamationmark_ground
@onready var warningmark_platform1 = $"Exclamationmark_platform1"
@onready var warningmark_platform2= $"Exclamationmark_platform2"
@onready var healthbar = $HealthBar

func _ready():
	if !GameManager.activatedCheckpoint:
		GameManager.level = level
		print(GameManager.level)
		GameManager.activatedCheckpoint = true
		GameManager.currentCheckpoint = null
	AudioManagerScene.play_music_boss_level(music_stream)


func _on_boss_tree_exited() -> void:
	bossbound.queue_free()
	ground.enabled = true
	platform2.enabled = false
	platform1.enabled = true
	warningmark_ground.visible = false
	warningmark_platform1.visible = false
	warningmark_platform2.visible = false
	healthbar.visible = false
	
