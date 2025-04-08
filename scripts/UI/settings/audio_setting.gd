extends Control

@onready var master_volume_slider = $Panel/VBoxContainer/MasterVolume
@onready var music_volume_slider = $Panel/VBoxContainer/MusicVolume
@onready var sfx_volume_slider = $Panel/VBoxContainer/SFXVolume
@onready var save_button = $Panel/VBoxContainer/HBoxContainer/Save

func _ready() -> void:
<<<<<<< Updated upstream
	master_volume_slider.value = ConfigFileManager.master_volume
	music_volume_slider.value = ConfigFileManager.music_volume
	sfx_volume_slider.value = ConfigFileManager.sfx_volume
=======
	master_volume_slider.value = ConfigFileManager.master_volume*100
	music_volume_slider.value = ConfigFileManager.music_volume*100
	sfx_volume_slider.value = ConfigFileManager.sfx_volume*100
>>>>>>> Stashed changes
	
	master_volume_slider.value_changed.connect(_on_master_volume_value_changed)
	music_volume_slider.value_changed.connect(_on_music_volume_value_changed)
	sfx_volume_slider.value_changed.connect(_on_sfx_volume_value_changed)
	
	save_button.visible = false

func _on_master_volume_value_changed(value: float) -> void:
<<<<<<< Updated upstream
	ConfigFileManager.master_volume = value
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
=======
	ConfigFileManager.master_volume = value/100
	AudioServer.set_bus_volume_db(0, linear_to_db(value/100))
>>>>>>> Stashed changes
	print(str(value))
	save_button.visible = true

func _on_music_volume_value_changed(value: float) -> void:
<<<<<<< Updated upstream
	ConfigFileManager.music_volume = value
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
=======
	ConfigFileManager.music_volume = value/100
	AudioServer.set_bus_volume_db(1, linear_to_db(value/100))
>>>>>>> Stashed changes
	print(str(value))
	save_button.visible = true

func _on_sfx_volume_value_changed(value: float) -> void:
<<<<<<< Updated upstream
	ConfigFileManager.sfx_volume = value
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
=======
	ConfigFileManager.sfx_volume = value/100
	AudioServer.set_bus_volume_db(2, linear_to_db(value/100))
>>>>>>> Stashed changes
	print(str(value))
	save_button.visible = true

func _on_save_pressed() -> void:
	ConfigFileManager.save_settings()
	save_button.visible = false
	
func _input(event) -> void:
	if event.is_action_pressed("Escape"):
		get_tree().change_scene_to_file("res://scenes/UI/settings/settings.tscn")
		ConfigFileManager.load_settings()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/settings/settings.tscn")
	ConfigFileManager.load_settings()
