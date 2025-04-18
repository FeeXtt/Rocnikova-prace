extends Node

var numberOfSave: int
var save_path: String
var loadlevel: String
var currentCheckpoint;
var activatedCheckpoint: bool;
var player;
var level: int;
var doorLevel: int;
var saveButtKeybinVisible: bool
@onready var audio_player = get_node("AudioPlayer")

func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	print(save_path)
	file.store_var(GameManager.level)
	file.store_var(GameManager.doorLevel)
	file.store_var(GameManager.activatedCheckpoint)
	

func load_data():
	save_path ="res://position"+str(numberOfSave)+ ".save"
	print(save_path)
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path,FileAccess.READ)
		GameManager.level = file.get_var(GameManager.level)
		GameManager.doorLevel = file.get_var(GameManager.doorLevel)
		GameManager.activatedCheckpoint = file.get_var(GameManager.activatedCheckpoint)
		
		
	loadlevel ="res://scenes/levels/level_"+str(GameManager.level)+".tscn"
	

func respawn_player():
	#doorLevel = level
	#get_tree().change_scene_to_file("res://scenes/levels/level_"+str(level)+".tscn")
	pass
func _input(event) -> void:
	if event.is_action_pressed("Reset"):
		doorLevel = level
		get_tree().change_scene_to_file("res://scenes/levels/level_"+str(level)+".tscn")
	#
	#
	
