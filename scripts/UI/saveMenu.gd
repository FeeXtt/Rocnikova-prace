extends Control

var loading_path

var saves_level = [null, null, null]
var save1_level
var save2_level
var save3_level


func _ready() -> void:
	load_saves()
	save1_level = $Panel/HBoxContainer/SAVE1/save1_text_level
	save2_level = $Panel/HBoxContainer/SAVE2/save2_text_level
	save3_level = $Panel/HBoxContainer/SAVE3/save3_text_level

func _process(delta: float) -> void:
	if saves_level[0] != null:
		save1_level.text ="level:" + str(saves_level[0]) 
	if saves_level[1] != null:
		save2_level.text ="level:" + str(saves_level[1]) 
	if saves_level[2] != null:
		save3_level.text ="level:" + str(saves_level[2]) 



func load_saves():
	for i in range(0, 3): 
		loading_path ="res://position"+str(i+1)+ ".save"
		if FileAccess.file_exists(loading_path):
			var file = FileAccess.open(loading_path,FileAccess.READ)
			saves_level[i] =  file.get_var(GameManager.level)
			print(loading_path)

func _on_save_1_pressed() -> void:
	GameManager.numberOfSave = 1
	GameManager.load_data()
	get_tree().change_scene_to_file(GameManager.loadlevel);
	

func _on_save_2_pressed() -> void:
	GameManager.numberOfSave = 2
	GameManager.load_data()
	get_tree().change_scene_to_file(GameManager.loadlevel);

func _on_save_3_pressed() -> void:
	GameManager.numberOfSave = 3
	GameManager.load_data()
	get_tree().change_scene_to_file(GameManager.loadlevel);
