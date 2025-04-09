extends Button

var waiting_for_input := false
@export var action_name := "MoveLeft"
@export var indexInArray = 1;

func _ready():
	var events = InputMap.action_get_events(action_name)
	print(str(events[0]))
	if events.size() > 0 and events[0] is InputEventKey :
		text = ConfigFileManager.binds[indexInArray]
		print(str(OS.get_keycode_string(events[0].keycode)))
	elif events.size() > 0 and events[0] is InputEventMouseButton:
		text = events[0].as_text()
	else:
		text = "Rebind"
	pressed.connect(_on_pressed)
	

func _on_pressed() -> void:
	if waiting_for_input:
		text = "..."
	else:
		text = "Press any key..."
		waiting_for_input = true

func _input(event):
	if not waiting_for_input:
		return
	if event is InputEventKey && event.pressed:
		waiting_for_input = false
		print(event.physical_keycode)
		text = event.as_text()
		ConfigFileManager.binds[indexInArray] = OS.get_keycode_string(event.physical_keycode)
		GameManager.saveButtKeybinVisible = true
		accept_event()
	elif event is InputEventMouseButton && event.pressed:
		waiting_for_input = false
		text = event.as_text()
		print(event.button_index)
		
		ConfigFileManager.binds[indexInArray] = "mouse_" + str(event.button_index)
		print(ConfigFileManager.binds[indexInArray])
		GameManager.saveButtKeybinVisible = true
		accept_event()
		
	
