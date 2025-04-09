extends Node


var config = ConfigFile.new()
const settings_file_path = "user://setting.ini"

var master_volume: float = 1
var music_volume: float = 1
var sfx_volume: float = 1
var binds: Array = ["W", "A", "S", "D" , "Space", "mouse_1"]
var bindsBeforeChange: Array = []
var bindNames = ["MoveUp", "MoveLeft", "MoveDown", "MoveRight", "jump", "fire"]

func _ready() -> void:
	load_settings()
	
	
func save_settings() -> void:
	config.set_value("audio", "master_volume", master_volume)
	config.set_value("audio", "music_volume", music_volume)
	config.set_value("audio", "sfx_volume", sfx_volume)
	print(settings_file_path)

	AudioServer.set_bus_volume_db(0, linear_to_db(master_volume))
	AudioServer.set_bus_volume_db(1, linear_to_db(music_volume))
	AudioServer.set_bus_volume_db(2, linear_to_db(sfx_volume))
	print(master_volume)
	print(music_volume)
	print(sfx_volume)
	print("save")


	for i in range(6):
		print(bindNames[i] + " " + binds[i])
		config.set_value("keybiding", bindNames[i], binds[i])
	config.save(settings_file_path)



func load_settings() -> void:
	if FileAccess.file_exists(settings_file_path):
		config.load(settings_file_path)
		master_volume = config.get_value("audio", "master_volume", master_volume)
		music_volume = config.get_value("audio", "music_volume", music_volume)
		sfx_volume = config.get_value("audio", "sfx_volume",  sfx_volume)

		print(master_volume)
		print(music_volume)
		print(sfx_volume)
		AudioServer.set_bus_volume_db(0, linear_to_db(master_volume))
		AudioServer.set_bus_volume_db(1, linear_to_db(music_volume))
		AudioServer.set_bus_volume_db(2, linear_to_db(sfx_volume))
		
		for i in range(6):
			binds[i] = config.get_value("keybiding", bindNames[i], binds[i])
			print(bindNames[i] + " " + binds[i])
			if binds[i].contains("mouse_"):
				InputMap.action_erase_events(bindNames[i])
				var event = InputEventMouseButton.new()
				event.button_index = int(binds[i].split("_")[1])
				InputMap.action_add_event(bindNames[i], event)
			else:
				InputMap.action_erase_events(bindNames[i])
				var event = InputEventKey.new()
				event.keycode = OS.find_keycode_from_string(ConfigFileManager.binds[i])
				InputMap.action_add_event(bindNames[i], event)
				
		print("load")
		bindsBeforeChange = binds

		
		config.set_value("keybiding", "MoveLeft", "A")
		config.set_value("keybiding", "MoveRight", "D")
		config.set_value("keybiding", "MoveUp", "W")
		config.set_value("keybiding", "MoveDown", "S")
		config.set_value("keybiding", "jump", "Space")
		config.set_value("keybiding", "fire", "mouse_1")

	else:
		master_volume = config.get_value("audio", "master_volume", 100)
		music_volume = config.get_value("audio", "music_volume", 100)
		sfx_volume = config.get_value("audio", "sfx_volume",  100)

		config.set_value("keybiding", "MoveUp", "W")
		config.set_value("keybiding", "MoveLeft", "A")
		config.set_value("keybiding", "MoveDown", "S")
		config.set_value("keybiding", "MoveRight", "D")
		config.set_value("keybiding", "jump", "Space")
		config.set_value("keybiding", "fire", "mouse_1")
	
