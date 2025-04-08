extends Node

var numberOfSave: int
var save_path: String
var loadlevel: String
var currentCheckpoint;
var activatedCheckpoint: bool;
var player;
var level: int;
var doorLevel: int;
<<<<<<< Updated upstream
=======
var saveButtKeybinVisible: bool
>>>>>>> Stashed changes

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
		
<<<<<<< Updated upstream
=======
		
>>>>>>> Stashed changes
	loadlevel ="res://scenes/levels/level_"+str(GameManager.level)+".tscn"
	

func respawn_player():
	doorLevel = level
<<<<<<< Updated upstream
	get_tree().change_scene_to_file("res://scenes/levels/level_"+str(level)+".tscn")
	get_tree().get_first_node_in_group("Player")
=======
	#get_tree().change_scene_to_file("res://scenes/levels/level_"+str(level)+".tscn")
	#get_tree().get_first_node_in_group("Player")
	
>>>>>>> Stashed changes

func reload_player():
	if currentCheckpoint != null:
		player.position = currentCheckpoint.global_position
		print("Respawn na checkpoint:", currentCheckpoint.global_position)
	
	
	
