extends Control

@onready var save_button = $Panel/VBoxContainer/HBoxContainer7/SaveButton


func _ready() -> void:
	save_button.visible = false

func _process(delta: float) -> void:
	save_button.visible = GameManager.saveButtKeybinVisible
	

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/settings/settings.tscn")
	ConfigFileManager.load_settings()

func _on_save_button_pressed() -> void:
	ConfigFileManager.save_settings()
	save_button.visible = false
	GameManager.saveButtKeybinVisible = false
	
func _input(event) -> void:
	if event.is_action_pressed("Escape"):
		get_tree().change_scene_to_file("res://scenes/UI/settings/settings.tscn")
		ConfigFileManager.load_settings()
