extends Node


var config = ConfigFile.new()
const settings_file_path = "user://setting.ini"

var master_volume: float = 1.0
var music_volume: float = 1.0
var sfx_volume: float = 1.0


func _ready() -> void:
	#if !FileAccess.file_exists(settings_file_path):
		#config.set_value("keybiding", "ui_left", "A")
		#config.set_value("keybiding", "ui_right", "D")
		#config.set_value("keybiding", "ui_up", "W")
		#config.set_value("keybiding", "ui_down", "S")
		#config.set_value("keybiding", "ui_accept", "Space")
		#config.set_value("keybiding", "fire", "mouse_1")
		#
		#config.set_value("audio", "master_volume", 1.0)
		#config.set_value("audio", "music_volume", 1.0)
		#config.set_value("audio", "sfx_volume", 1.0)
		#
		#config.save(settings_file_path)
	#else:
	
	load_settings()

func save_settings() -> void:
	config.set_value("audio", "master_volume", master_volume)
	config.set_value("audio", "music_volume", music_volume)
	config.set_value("audio", "sfx_volume", sfx_volume)
	config.save(settings_file_path)
	print(settings_file_path)

	AudioServer.set_bus_volume_db(0, linear_to_db(master_volume))
	AudioServer.set_bus_volume_db(1, linear_to_db(music_volume))
	AudioServer.set_bus_volume_db(2, linear_to_db(sfx_volume))
	print(master_volume)
	print(music_volume)
	print(sfx_volume)
	print("save")



func load_settings() -> void:
	if FileAccess.file_exists(settings_file_path):
		config.load(settings_file_path)
		master_volume = config.get_value("audio", "master_volume", master_volume)
		music_volume = config.get_value("audio", "music_volume", music_volume)
		sfx_volume = config.get_value("audio", "sfx_volume",  sfx_volume)
		print("load")

		
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

		
		config.set_value("keybiding", "MoveLeft", "A")
		config.set_value("keybiding", "MoveRight", "D")
		config.set_value("keybiding", "MoveUp", "W")
		config.set_value("keybiding", "MoveDown", "S")
		config.set_value("keybiding", "jump", "Space")
		config.set_value("keybiding", "fire", "mouse_1")

	
	print(master_volume)
	print(music_volume)
	print(sfx_volume)
	
	
	AudioServer.set_bus_volume_db(0, linear_to_db(master_volume))
	AudioServer.set_bus_volume_db(1, linear_to_db(music_volume))
	AudioServer.set_bus_volume_db(2, linear_to_db(sfx_volume))
