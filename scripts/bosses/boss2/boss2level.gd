extends Node2D
var level = 11
@export var music_stream = preload("res://assets/audio/Music/CiscoIsShite.mp3")
@onready var bossbound = $BossBound
@onready var ending = $CanvasLayer/Ending


func _ready() -> void:
	if !GameManager.activatedCheckpoint:
		GameManager.level = level
		print(GameManager.level)
		GameManager.activatedCheckpoint = true
		GameManager.currentCheckpoint = null
	AudioManagerScene.play_music_boss_level(music_stream)
	
	


func _on_boss_2_child_exiting_tree(node: Node) -> void:
	for idk in get_tree().get_nodes_in_group("marks"):
		idk.queue_free()
	bossbound.queue_free()
	await get_tree().create_timer(3).timeout
	ending.visible = true
	
